extends Control

signal play_button_pressed

onready var score_label = $CenterContainer/VBoxContainer/ScoreLabel
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	$CenterContainer/VBoxContainer/PlayerSprite/projectile.show()
	$CenterContainer/VBoxContainer/PlayerSprite/flower_anim.hide()
	$CenterContainer/VBoxContainer/PlayerSprite/stem.hide()
	$CenterContainer/VBoxContainer/PlayerSprite/eye_anim.hide()
	$CenterContainer/VBoxContainer/PlayerSprite/eye_burst.hide()
	score_label.text = str(player_vars.score) + " planets"

func _on_play_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")
