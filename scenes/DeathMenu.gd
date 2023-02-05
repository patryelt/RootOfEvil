extends Node2D

signal play_button_pressed

func _on_play_pressed():
	print("PLAY")
	emit_signal("play_button_pressed")
