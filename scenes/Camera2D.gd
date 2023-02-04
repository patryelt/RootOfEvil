extends Camera2D

var target : Node2D
const FOLLOW_SPEED = 4.0

func _process(delta):
	if target:
		position = position.linear_interpolate(target.position, delta * FOLLOW_SPEED)
