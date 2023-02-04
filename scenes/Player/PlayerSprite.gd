extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func leave():
	$eye_anim.hide()
	

func jump():
	$stem.hide()
	$flower_anim.hide()
	$bulb_anim.hide()
