extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var camera = $Camera2D
	$Planet2.camera = camera
	$Planet3.camera = camera
	$Planet3/Player.camera = camera
	camera.target = $Planet3


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
