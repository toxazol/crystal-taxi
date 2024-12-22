extends Area3D

@export var maxCarSpeed = 3

var isActive = false
var passengerJoint: Node3D = null

var current_passenger: RigidBody3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_passenger:
		if current_passenger.linear_velocity.length() < maxCarSpeed:
			if current_passenger in get_overlapping_bodies():
				dropOff()


func _on_body_entered(dude):
	if !isActive || !dude || !dude.is_in_group("Passenger"):
		return
	current_passenger = dude
	if current_passenger.linear_velocity.length() > maxCarSpeed:
		print_debug("too fast to get off")
		return
	dropOff()
	
func dropOff():
	passengerJoint.free()
	current_passenger.getOff()
	isActive = false
	hide()
	current_passenger = null
	print("Thanks for the ride!")
	get_parent().activate_next_quest()

func set_passenger_joint(joint: Node3D):
	passengerJoint = joint
