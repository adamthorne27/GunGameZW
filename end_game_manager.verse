
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Teams }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }



# A Verse-authored creative device that can be placed in a level
end_game_manager := class(creative_device):



    @editable
    var WinTracker : tracker_device = tracker_device{}





    @editable
    var WinningTP : teleporter_device = teleporter_device{}



    @editable
    var EndGameDevice : end_game_device = end_game_device{}

    @editable
    var WinScreen : cinematic_sequence_device = cinematic_sequence_device{}


    @editable
    var ShowRank : []creative_prop = array{}

    @editable
    VicRoyTimer : timer_device = timer_device{}

   

    @editable
    var Storm : advanced_storm_controller_device = advanced_storm_controller_device{}
    


    @editable
    var MutatorZone : mutator_zone_device = mutator_zone_device{}
    

    @editable
    var WinningPlayer : []player_reference_device = array{}

    @editable
    var PlayerWins : billboard_device = billboard_device{}


    @editable
    var ConditionalButton : conditional_button_device = conditional_button_device{}

    var Rank : int = 0

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        ConditionalButton.ActivatedEvent.Subscribe(EndGame)
        for (HideRank : ShowRank):
            HideRank.Hide()

    
    Ranker(Agent: agent): int=
        Value := WinTracker.GetValue(Agent)
            if (Value = 0):
                set Rank = 0
            else if (Value = 1):
                set Rank = 1
            else if (Value > 1 and Value <= 4):
                set Rank = 2
            else if (Value >= 5 and Value <= 9):
                set Rank = 3
            else if (Value >= 10 and Value <= 14):
                set Rank = 4
            else if (Value >= 15 and Value <= 19):
                set Rank = 5
            else if (Value >= 20 and Value <= 29):
                set Rank = 6
            else if (Value >= 30 and Value <= 39):
                set Rank = 7
            else if (Value >= 40):
                set Rank = 8
        return Rank
    

    TextForUI <localizes> (InTest :string) : message = "{InText}"

    StringForUI <localizes> (InTest :string) : message = "{InText}"

    PlayerName<localizes>(PlayerID:agent):message = "{Agent}"

    
    SetDynamicText<localizes>(IntValue:int) : message = "Wins: {IntValue}"

    EndGame(Player : agent): void=
        WinTracker.Increment(Player)
        for (Reference : WinningPlayer):
            Reference.Register(Player)
        TotalWins := SetDynamicText(WinTracker.GetValue(Player))
        PlayerWins.SetText(TotalWins)
        Storm.DestroyStorm()
            if(FortniteCharacter : fort_character = Player.GetFortCharacter[]):
                # Gets player position
                PlayerPosition : vector3 = WinningTP.GetTransform().Translation
                WinningRotation : rotation = MutatorZone.GetTransform().Rotation
                if (FortniteCharacter.TeleportTo[PlayerPosition, WinningRotation]):
                    # Print("Teleported")
                else:
                    # Print("Failed")
                Ranker(Player)
                case (Rank):
                    0 => if (Unranked := ShowRank[0]):
                        Unranked.Show()
                    1 => if (Bronze := ShowRank[1]):
                         Bronze.Show()
                    2 => if (Silver := ShowRank[2]):
                        Silver.Show()
                    3 => if (Gold := ShowRank[3]):
                        Gold.Show()
                    4 => if (Platinum := ShowRank[4]):
                        Platinum.Show()
                    5 => if (Diamond := ShowRank[5]):
                        Diamond.Show()
                    6 => if (Elite := ShowRank[6]):
                        Elite.Show()
                    7 => if (Champion := ShowRank[7]):
                        Champion.Show()
                    8 => if (Unreal := ShowRank[8]):
                        Unreal.Show()
                    _ => Print("Failed")
                VicRoyTimer.Start()
                WinScreen.Play()
            VicRoyTimer.SuccessEvent.Subscribe(EndRound)


    EndRound(Player : ?agent): void=
        if (Agent := player[Player?]):
            EndGameDevice.Activate(Agent)




