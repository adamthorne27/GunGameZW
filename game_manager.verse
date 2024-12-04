
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Teams }
using { /Fortnite.com/Characters }
using { /Verse.org/Random }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation/Tags }

Loadout1 := class(tag){}
Loadout2 := class(tag){}
Loadout3 := class(tag){}                            
Loadout4 := class(tag){}
Loadout5 := class(tag){}

# A Verse-authored creative device that can be placed in a level
game_manager := class(creative_device):


    var PlayerMap : [player]int = map{}

    @editable
    var StartingWeapons1 : item_granter_device = item_granter_device{}

    @editable
    var StartingWeapons2 : item_granter_device = item_granter_device{}

    @editable
    var StartingWeapons3 : item_granter_device = item_granter_device{}

    @editable
    var StartingWeapons4 : item_granter_device = item_granter_device{}
    
    @editable
    var StartingWeapons5 : item_granter_device = item_granter_device{}

    @editable
    var WeaponCounter1 : player_counter_device = player_counter_device{}

    @editable
    var WeaponCounter2 : player_counter_device = player_counter_device{}

    @editable
    var WeaponCounter3 : player_counter_device = player_counter_device{}

    @editable
    var WeaponSwitch1 : switch_device = switch_device{}

    @editable
    var WeaponSwitch2 : switch_device = switch_device{}

    @editable
    var WeaponSwitch3 : switch_device = switch_device{}

    @editable 
    var PlayerJoinTP : teleporter_device = teleporter_device{}

    @editable
    var SpawningTP : teleporter_device = teleporter_device{}

    @editable
    var TimerDevice : timer_device = timer_device{}

    @editable
    var Teleporter : teleporter_device = teleporter_device{}

    @editable
    var XPAward : accolades_device = accolades_device{} 

    @editable
    var XPTracker : tracker_device = tracker_device{}

    var ElimsToEndGame : int = 0



    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # InitializePlayers()
        WeaponSwitch1.TurnedOnEvent.Subscribe(OnSwitch1TurnedOn)
        WeaponSwitch2.TurnedOnEvent.Subscribe(OnSwitch2TurnedOn)
        WeaponSwitch3.TurnedOnEvent.Subscribe(OnSwitch3TurnedOn)
        TimerDevice.SuccessEvent.Subscribe(OnLoadoutTimerSuccess)
        Self.GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
        TimerDevice.SuccessEvent.Subscribe(TeleportPlayers)
        XPTracker.CompleteEvent.Subscribe(AwardXP)



    AwardXP(Agent : agent):void=
        XPAward.Award(Agent)
    
    OnSwitch1TurnedOn(Agent : agent): void=
        WeaponCounter1.Register(Agent)
        WeaponSwitch2.TurnOff(Agent)
        WeaponSwitch3.TurnOff(Agent)
        WeaponCounter2.Unregister(Agent)
        WeaponCounter3.Unregister(Agent)


    OnSwitch2TurnedOn(Agent : agent): void=
            WeaponCounter2.Register(Agent)
            WeaponSwitch1.TurnOff(Agent)
            WeaponSwitch3.TurnOff(Agent)
            WeaponCounter1.Unregister(Agent)
            WeaponCounter3.Unregister(Agent)

    OnSwitch3TurnedOn(Agent : agent): void=
                WeaponCounter3.Register(Agent)
                WeaponSwitch1.TurnOff(Agent)
                WeaponSwitch2.TurnOff(Agent)
                WeaponCounter1.Unregister(Agent)
                WeaponCounter2.Unregister(Agent)

    OnLoadoutTimerSuccess(Agent : ?agent):void=
        if (WeaponCounter1.GetCount() > WeaponCounter2.GetCount() and WeaponCounter3.GetCount()):
            ChooseLoadout1()
        else if (WeaponCounter2.GetCount() > WeaponCounter1.GetCount() and WeaponCounter3.GetCount()):
            ChooseLoadout2()
        else if (WeaponCounter3.GetCount() > WeaponCounter2.GetCount() and WeaponCounter1.GetCount()):
            ChooseLoadout3()
        else: 
            Rand := GetRandomInt(1,3)
            if (Rand = 1):
               ChooseLoadout1()
            else if (Rand = 2):
                ChooseLoadout2()
            else:
                ChooseLoadout3()
    

    ChooseLoadout1(): void=
        for (Player : GetPlayspace().GetPlayers()):
            StartingWeapons1.GrantItem(Player)


    ChooseLoadout2(): void=
        for (Player : GetPlayspace().GetPlayers()):
            StartingWeapons2.GrantItem(Player)



    ChooseLoadout3(): void=
        Rand := GetRandomInt(3,5)
            if (Rand = 3):
                for (Player : GetPlayspace().GetPlayers()):
                    StartingWeapons3.GrantItem(Player)
            else if (Rand = 4):
                for (Player : GetPlayspace().GetPlayers()):
                    StartingWeapons4.GrantItem(Player)
            else:
                for (Player : GetPlayspace().GetPlayers()):
                    StartingWeapons5.GrantItem(Player)
            

        
    <#
    InitializePlayers() : void=
            AllPlayers := GetPlayspace().GetPlayers()
            for (Player : AllPlayers):
                StartingWeapons.GrantItem(Player)

                #>
        
    TeleportPlayers(Agent: ?agent):void=
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            Teleporter.Teleport(Player)

    OnPlayerAdded(Player : player): void=
                InitializePlayer(Player)
                spawn:
                    TeleportNewPlayer(Player)



                


    InitializePlayer(Player : player): void=
        if (WeaponCounter1.GetCount() > WeaponCounter2.GetCount() and WeaponCounter3.GetCount()):
            ChooseLoadout1AddedPlayer(Player)
        else if (WeaponCounter2.GetCount() > WeaponCounter1.GetCount() and WeaponCounter3.GetCount()):
            ChooseLoadout2AddedPlayer(Player)
        else if (WeaponCounter3.GetCount() > WeaponCounter2.GetCount() and WeaponCounter1.GetCount()):
            ChooseLoadout3AddedPlayer(Player)
        else: 
            Rand := GetRandomInt(1,3)
            if (Rand = 1):
               ChooseLoadout1AddedPlayer(Player)
            else if (Rand = 2):
                ChooseLoadout2AddedPlayer(Player)
            else:
                ChooseLoadout3AddedPlayer(Player)

    ChooseLoadout1AddedPlayer(Agent : agent): void=
        StartingWeapons1.GrantItem(Agent)
            
    ChooseLoadout2AddedPlayer(Agent : agent): void=
                        StartingWeapons2.GrantItem(Agent)
                
            
    ChooseLoadout3AddedPlayer(Agent : agent): void=
                    Rand := GetRandomInt(3,5)
                        if (Rand = 3):
                            StartingWeapons3.GrantItem(Agent)
                        else if (Rand = 4):
                            StartingWeapons4.GrantItem(Agent)
                        else:
                            StartingWeapons5.GrantItem(Agent)
                        
 
        

    



    PromotePlayer(Agent : agent) : void=
        var WeaponTier : int = 0
        if (Player := player[Agent], PlayerWeaponTier := PlayerMap[Player]):
            set WeaponTier = PlayerWeaponTier + 1


    TestPlayerElimination(Agent : ?agent) : void=
        if (Player := Agent?):
            PromotePlayer(Player)

    TeleportNewPlayer (Agent : agent) <suspends> : void=
        Sleep(0.1)
        PlayerJoinTP.Teleport(Agent)



    TextForUI <localizes> (InTest :string) : message = "{InText}"


    PlayerName<localizes>(PlayerID:agent):message = "{Agent}"


    



