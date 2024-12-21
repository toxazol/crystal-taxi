extends RigidBody3D

@export var animator: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sit():
	print_debug('dude sits')
	animator.queue("Sit_Floor_Down")

func getOff():
	print_debug("dude is getting off")
	global_position += transform.basis.y * 1.5 + transform.basis.z * 2
	#apply_force(transform.basis.y * 200 + transform.basis.z * 100)
	#apply_force(transform.basis.y * 200)
	#apply_force(Vector3.UP * 200 + Vector3.LEFT * 400)
	animator.queue("Jump_Full_Short")
