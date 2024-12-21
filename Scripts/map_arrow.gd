extends Control

@export var playerCar: Node3D
var currentTarget = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !currentTarget:
		return
	
	var dir = currentTarget.global_position - playerCar.global_position

	rotation = atan2(dir.z, dir.x) + PI/2 + playerCar.global_rotation.y

func look_at(target: Node3D):
	show()
	currentTarget = target

func stop_looking():
	currentTarget = null
	hide()
