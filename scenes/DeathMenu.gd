extends Node2D

signal play_button_pressed

onready var score_label = $CenterContainer/VBoxContainer/ScoreLabel

func _ready():
	$CenterContainer/VBoxContainer/PlayerSprite/projectile.show()
	$CenterContainer/VBoxContainer/PlayerSprite/flower_anim.hide()
	$CenterContainer/VBoxContainer/PlayerSprite/stem.hide()
	$CenterContainer/VBoxContainer/PlayerSprite/eye_anim.hide()
	$CenterContainer/VBoxContainer/PlayerSprite/eye_burst.hide()

func _on_play_pressed():
	emit_signal("play_button_pressed")

func set_score(score):
	score_label.text = str(score) + " planets"
