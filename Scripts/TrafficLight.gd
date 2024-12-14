extends Area3D


# Reference to the child MeshInstance3D
@export var mesh_instance: MeshInstance3D
@export var current_state: State = State.GREEN
@export var CHANGE_INTERVAL: float = 1.0

enum State {GREEN, YELLOW, RED}

# Timer for color swapping
var color_timer: float = 0.0


func _ready():
	if current_state == State.GREEN:
		mesh_instance.material_override.albedo_color = Color.LIME_GREEN
	else:
		mesh_instance.material_override.albedo_color = Color.INDIAN_RED

func _process(delta: float):
	# Increment the timer
	color_timer += delta

	# Check if it's time to swap colors
	if color_timer >= CHANGE_INTERVAL:
		color_timer = 0.0
		_swap_color()


func _swap_color():
	# Swap between green and red
	if current_state == State.GREEN:
		current_state = State.RED
		for body in get_overlapping_bodies():
			print_debug("red light for " + body.name)
			if body.has_method("on_red_light"):
				body.on_red_light()
	else: 
		current_state = State.GREEN
		for body in get_overlapping_bodies():
			print_debug("green light for " + body.name)
			if body.has_method("on_green_light"):
				body.on_green_light()
	mesh_instance.material_override.albedo_color = Color.INDIAN_RED if current_state == State.RED else Color.LIME_GREEN


func _on_body_entered(body: Node3D) -> void:
	print_debug("red light (on enter) for " + body.name)
	if current_state == State.RED:
		if body.has_method("on_red_light"):
			body.on_red_light()
