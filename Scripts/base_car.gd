extends VehicleBody3D


@export var STEER_SPEED = 1.5
@export var STEER_LIMIT = 0.6
@export var engine_force_value = 35
var steer_target = 0

func _ready() -> void:
	$wheal2.wheel_friction_slip=0.8
	$wheal3.wheel_friction_slip=0.8

func _physics_process(delta):
	var speed = linear_velocity.length()*Engine.get_frames_per_second()*delta
	traction(speed)
	#$Hud/speed.text=str(round(speed*3.8))+"  KMPH"
	
	steer_target = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	steer_target *= STEER_LIMIT
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
	
	var signed_speed = transform.basis.z.dot(linear_velocity.normalized()) * linear_velocity.length()
	#print_debug(speed)
	if Input.is_action_pressed("ui_down"):
		if signed_speed < -1:
			brake = 2
		else:
			engine_force = engine_force_value
	elif Input.is_action_pressed("ui_up"):
		if signed_speed > 1:
			brake = 2
		else:
			# Increase engine force at low speeds to make the initial acceleration faster.
			if speed < 10:
				engine_force = -clamp(engine_force_value * 10 / speed, 0, 200)
			else:
				engine_force = -engine_force_value
	else:
		engine_force = 0
		brake = 0




func traction(speed):
	apply_central_force(Vector3.DOWN*speed)
