using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Teams }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }

static_weapon_refill := class(creative_device):


    @editable
    var FishGranter : item_granter_device = item_granter_device{}
    
    @editable
    var GrappleGranter : item_granter_device = item_granter_device{}

    @editable 
    var ElimManager : elimination_manager_device = elimination_manager_device{}


    OnBegin<override>()<suspends>:void=
        ElimManager.EliminationEvent.Subscribe(GrappleFishGranter)

    GrappleFishGranter(Player: ?agent): void=
            if (Agent := player[Player?]):
                spawn:
                    GrantItems(Agent)

    GrantItems(Agent: agent)<suspends>: void=
        Sleep(0.1)
        FishGranter.GrantItem(Agent)
        GrappleGranter.GrantItem(Agent)

