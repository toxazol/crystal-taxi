extends Control

# Create an AsyncScene instance to handle the loading process
var scene : AsyncScene = null

# Export the path to the scene you want to load
@export var scenePath : String = "res://Scenes/DemoLevel.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene = AsyncScene.new(scenePath, AsyncScene.LoadingSceneOperation.Replace)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Transition2.play("fade_out")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	scene.ChangeScene()
