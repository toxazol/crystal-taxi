extends VehicleBody3D


@export var STEER_SPEED = 1.5
@export var STEER_LIMIT = 0.6
@export var engine_force_value = 35
@export var pitch_div = 1.5
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
			enforce_engine(engine_force_value)
	elif Input.is_action_pressed("ui_up"):
		if signed_speed > 1:
			brake = 2
		else:
			# Increase engine force at low speeds to make the initial acceleration faster.
			if speed < 10:
				enforce_engine(-clamp(engine_force_value * 10 / speed, 0, 200))
			else:
				enforce_engine(-engine_force_value)
	else:
		enforce_engine(0)
		brake = 0

func enforce_engine(force):
	engine_force = force
	#var pitch = abs(engine_force) / pitch_div
	var pitch = pitch_div if abs(engine_force) > 0 else 1
	#if pitch < 1:
		#pitch = 1
	$brbrSound.pitch_scale = pitch
	if pitch > 1:
		if !$brrrrSound.playing:
			$brrrrSound.play()
	else:
		$brrrrSound.stop()



func traction(speed):
	apply_central_force(Vector3.DOWN*speed)
