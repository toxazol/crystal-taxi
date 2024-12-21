extends Node3D


var pickupAreas: Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is PickupArea: 
			pickupAreas.append(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func activate_next_quest():
	for area in pickupAreas:
		if !area.isVisited:
			area.isActive = true
			area.show() 
