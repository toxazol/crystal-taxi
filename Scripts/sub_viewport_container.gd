extends SubViewportContainer


func _ready():
	# Apply shader to the container
	material = ShaderMaterial.new()
	material.shader = preload("res://Materials/Shaders/cicularShader.gdshader")
