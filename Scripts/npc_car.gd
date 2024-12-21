extends VehicleBody3D


@export var STEER_SPEED = 1.0
@export var STEER_LIMIT = 0.6
var steer_target = 0
@export var engine_force_value = 20

@export var move_limit_sq: float = 25.0

var curPathIdx = 0
@export var path: Path3D

var isMove = true

func _physics_process(delta):

	if isMove:
		engine_force = -engine_force_value
		brake = 0
		$ActiveRearLights.visible = false
		$InactiveRearLights.visible = true
	else:
		engine_force = 0
		brake = 2
		$ActiveRearLights.visible = true
		$InactiveRearLights.visible = false
		return
	
	var speed = linear_velocity.length()*Engine.get_frames_per_second()*delta
	traction(speed)
	
	if speed < 20 and speed != 0:
		engine_force = clamp(-engine_force_value * 2 / speed, -300, 0)
	
	#print_debug(curPathIdx)

	var target_vector = path.curve.get_point_position(curPathIdx) - position
	
	#print_debug(path.curve.get_point_position(curPathIdx))

	
	if target_vector.length_squared() < move_limit_sq:
		curPathIdx += 1
		if curPathIdx >= path.curve.get_point_count():
			curPathIdx -= path.curve.get_point_count()
	
	var fwd = -transform.basis.z
	steer_target = fwd.signed_angle_to(target_vector, Vector3.UP)
	steer_target *= STEER_LIMIT

		
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)


func traction(speed):
	apply_central_force(Vector3.DOWN*speed)

func on_red_light():
	#print_debug("i have to stop")
	isMove = false
	
func on_green_light():
	isMove = true


func _on_monitor_area_body_entered(body: Node3D) -> void:
	isMove = false


func _on_monitor_area_body_exited(body: Node3D) -> void:
	if $MonitorArea.get_overlapping_bodies().is_empty():
		isMove = true
