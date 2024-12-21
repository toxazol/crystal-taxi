extends Area3D
class_name PickupArea

@export var dude: Node3D
@export var targetArea: Node3D
@export var maxCarSpeed = 3

var current_car: RigidBody3D = null
@export var isActive = false
var isVisited = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_car:
		if current_car.linear_velocity.length() < maxCarSpeed:
			pick_up()


func _on_body_entered(playerCar):
	if !isActive || !playerCar.is_in_group("Player"):
		return
	current_car = playerCar
	if current_car.linear_velocity.length() > maxCarSpeed:
		print_debug("too fast to pick up")
		return
	pick_up()


func pick_up():
	# teleport dude to a sit
	var seat = current_car.get_node("Seat")
	dude.global_transform = seat.global_transform
	
	dude.sit()
	dude.reparent(get_parent())
	
	var joint = Generic6DOFJoint3D.new()
	joint.set_node_a(current_car.get_path())
	joint.set_node_b(dude.get_path())
	current_car.add_child(joint)
	
	targetArea.set_passenger_joint(joint)
	
	isActive = false
	isVisited = true
	hide()
	
	if targetArea:
		targetArea.isActive = true
		targetArea.show()
		get_parent().arrow_look_at(targetArea)
		
	current_car = null
