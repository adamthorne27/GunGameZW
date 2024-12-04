using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Teams }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }

respawn_manager := class(creative_device):

    @editable
    var Spawners : []player_spawner_device = array{}

    @editable
    var GrappleRefill : item_remover_device = item_remover_device{}

    @editable
    var GrappleGranter : item_granter_device = item_granter_device{}

    @editable
    var FishGranter : item_granter_device = item_granter_device{}

    @editable
    var MaterialGranter : item_granter_device = item_granter_device{}

    @editable
    var NewPlayerTP : teleporter_device = teleporter_device{}

    @editable
    var RemoveMats : item_remover_device = item_remover_device{}

    OnBegin<override>()<suspends>:void=
        for (Spawner : Spawners):
            Spawner.SpawnedEvent.Subscribe(RespawnMats)
            Spawner.SpawnedEvent.Subscribe(TP)


    
    RespawnMats(Agent: agent): void=
            RemoveMats.Remove(Agent)
            GrappleRefill.Remove(Agent)
            MaterialGranter.GrantItem(Agent)
            FishGranter.GrantItem(Agent)
            GrappleGranter.GrantItem(Agent)
            # Print("Removal")
            # GrappleGranter.GrantItem(Agent)

    TP(Agent : agent): void=
        spawn:
            TPToZone(Agent)

    TPToZone  (Agent: agent)<suspends>: void=
        NewPlayerTP.Teleport(Agent)
