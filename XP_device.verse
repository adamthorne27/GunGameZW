
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Teams }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation/Tags }

Coins := class(tag){}

# A Verse-authored creative device that can be placed in a level
xp_device := class(creative_device):


    @editable
    var GiveXP : accolades_device = accolades_device{}

    @editable
    var Teleporter : teleporter_device = teleporter_device{}

    @editable
    var MutatorZone : mutator_zone_device = mutator_zone_device{}


    OnBegin<override>()<suspends>:void=
        SetUpXP()
        Teleporter.TeleportedEvent.Subscribe(MakeInvulnerable)
        MutatorZone.AgentEntersEvent.Subscribe(MakeVulnerable)

    
    SetUpXP(): void=
        Coin := GetCreativeObjectsWithTag(Coins{})
        for (CoinItems : Coin, CoinItem := collectible_object_device[CoinItems]):
            CoinItem.CollectedEvent.Subscribe(AwardXP)

    AwardXP(Agent: agent): void=
        Print("Awarding XP")
        GiveXP.Award(Agent)

    MakeInvulnerable(Agent: agent): void=
        if (Character := Agent.GetFortCharacter[]):
            Print("Trying to be invulnerable")
            Character.SetVulnerability(false)
    

    MakeVulnerable(Agent: agent): void=
        if (Character := Agent.GetFortCharacter[]):
            Character.SetVulnerability(true)

            
