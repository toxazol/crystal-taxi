extends Area3D


# Reference to the child MeshInstance3D
@export var mesh_instance: MeshInstance3D
@export var current_state: State = State.GREEN
@export var CHANGE_INTERVAL: float = 1.0

enum State {GREEN, YELLOW, RED}

# Timer for color swapping
var color_timer: float = 0.0


func _ready():
	turn_light_on(current_state)

func _process(delta: float):
	# Increment the timer
	color_timer += delta

	# Check if it's time to swap colors
	if color_timer >= CHANGE_INTERVAL:
		color_timer = 0.0
		_swap_color()

func turn_light_on(state: State):
	for light in $Lights.get_children():
		if light.name == State.keys()[state]:
			light.show()
		else:
			light.hide()

func _swap_color():
	current_state = (int(current_state) + 1) % State.size()
	
	turn_light_on(current_state)
	
	if current_state == State.RED:
		notify_nearby_cars("on_red_light")
	elif current_state == State.GREEN: 
		notify_nearby_cars("on_green_light")
		


func _on_body_entered(body: Node3D) -> void:
	#print_debug("red light (on enter) for " + body.name)
	if current_state == State.RED:
		if body.has_method("on_red_light"):
			body.on_red_light()

func notify_nearby_cars(method):
	for body in get_overlapping_bodies():
		#print_debug("red light for " + body.name)
		if body.has_method(method):
			body.call(method)
