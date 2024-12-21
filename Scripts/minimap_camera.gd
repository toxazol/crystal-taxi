extends Camera3D

@export var followTarget: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_transform.origin.x = followTarget.global_transform.origin.x
	global_transform.origin.z = followTarget.global_transform.origin.z
	
	global_rotation.y = followTarget.global_rotation.y
