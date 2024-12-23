extends Node3D


var pickupAreas: Array[Node] = []
@export var navArrow: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is PickupArea: 
			pickupAreas.append(child)
	arrow_look_at(pickupAreas[0]) #look at first pickup area

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func activate_next_quest():
	#navArrow.stop_looking()
	for area in pickupAreas:
		if !area.isVisited:
			area.isActive = true
			area.show() 
			arrow_look_at(area)
			return
	# all areas have been visited:
	get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")


func arrow_look_at(targetArea):
	navArrow.look_at(targetArea)
