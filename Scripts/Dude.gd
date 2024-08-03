extends RigidBody3D

@onready var animator = $Model/Animator

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sit():
	animator.queue("Sit_Floor_Down")
