extends VehicleBody3D


@export var STEER_SPEED = 1.0
@export var STEER_LIMIT = 0.6
var steer_target = 0
@export var engine_force_value = 20

@export var test_destination: Node3D
@export var move_limit_sq: float = 25.0

var curPathIdx = 0
@export var path: Path3D


func _physics_process(delta):
	
	var speed = linear_velocity.length()*Engine.get_frames_per_second()*delta
	traction(speed)
	
	#print_debug(curPathIdx)

	var isMove = true
	#var target_vector = test_destination.position - position
	var target_vector = path.curve.get_point_position(curPathIdx) - position
	
	print_debug(test_destination.position)
	print_debug(path.curve.get_point_position(curPathIdx))

	
	if target_vector.length_squared() < move_limit_sq:
		isMove = false
		curPathIdx += 1
		if curPathIdx >= path.curve.get_point_count():
			curPathIdx -= path.curve.get_point_count()
	
	var fwd = -transform.basis.z
	steer_target = fwd.signed_angle_to(target_vector, Vector3.UP)
	steer_target *= STEER_LIMIT

	engine_force = 0
	
	if isMove:
		engine_force = -engine_force_value
	else:
		brake = 3
		
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)



func traction(speed):
	apply_central_force(Vector3.DOWN*speed)
