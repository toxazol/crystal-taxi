extends Area3D

@export var current_state: State = State.GREEN
@export var CHANGE_INTERVAL: float = 1.0
var yellow_interval: float = 0.5
var changeStep = 1 # -1 when going backwards, i.e. red->yellow->green

enum State {GREEN, YELLOW, RED}

# Timer for color swapping
var color_timer: float = 0.0


func _ready():
	yellow_interval = CHANGE_INTERVAL / 2
	turn_light_on(current_state)

func _process(delta: float):
	# Increment the timer
	color_timer += delta

	# Check if it's time to swap colors
	if color_timer >= getChangeInterval():
		color_timer = 0.0
		swap_color()

func getChangeInterval():
	if current_state == State.YELLOW:
		return yellow_interval
	return CHANGE_INTERVAL

func turn_light_on(state: State):
	for light in $Lights.get_children():
		if light.name == State.keys()[state]:
			light.show()
		else:
			light.hide()
	if state == State.RED:
		notify_nearby_cars("on_red_light")
	elif state == State.GREEN: 
		notify_nearby_cars("on_green_light")

func swap_color():
	var next_state = int(current_state) + changeStep
	if next_state >= State.size() || next_state < 0:
		changeStep *= -1
	current_state = int(current_state) + changeStep
	turn_light_on(current_state)


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
