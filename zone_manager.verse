using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Teams }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }

zone_manager := class(creative_device):


    @editable 
    var Teleporters : []teleporter_device = array{}

    @editable
    var TimerDevice : timer_device = timer_device{}

    @editable
    Storm : advanced_storm_controller_device = advanced_storm_controller_device{}

    
    var ShouldTP : logic = false

    var Position : string = ("0,0,0")
    
    MoveToPos : vector3 = vector3 {X := -50.0, Y := 155492.0, Z := 10000.0} 
    
    OnBegin<override>()<suspends>:void=
        TimerDevice.SuccessEvent.Subscribe(OnTimerComplete)
        
    OnTimerComplete(InAgent : ?agent) : void=
            for (Teleporter : Teleporters):
                spawn:
                    MoveTP(Teleporter)

        
    MoveTP(Teleporter : teleporter_device) <suspends> :void =
            # Print("Moving")
            MoveToRotation : rotation = MakeRotation(vector3{X := 0.0, Y := 0.0, Z := 0.0}, 0.0)
            Teleporter.MoveTo(MoveToPos, MoveToRotation, 600.0)
    
