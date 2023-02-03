extends Node2D

export(int, 1, 10) var rotation_speed = 1
enum Direction {CLOCKWISE = 1, COUNTERCLOCKWISE = -1}
export(Direction) var direction
# export(int, "Clockwise", "Counter-Clockwise") var direction = 1



# Called when the node enters the scene tree for the first time.
func _ready():
	print(direction)
	$RotationPlayer.playback_speed = rotation_speed * direction
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
