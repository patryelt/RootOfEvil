extends Node2D

var planet : Node2D
onready var jump_ray = $JumpRay

func _ready():
	planet = get_parent()

func _get_jump_direction():
	var up_direction = (self.position).normalized()
	var forward_direction = Vector2(up_direction.y, up_direction.x)
	if planet.direction == 1:
		forward_direction.x = -forward_direction.x
	else:
		forward_direction.y = -forward_direction.y
	return up_direction.linear_interpolate(forward_direction, planet.rotation_speed)

func jump():
	var jump_direction = _get_jump_direction()
	# TODO

func _show_jump_ray():
	var jump_direction = _get_jump_direction()
	jump_ray.set_point_position(1, jump_direction * 1000)
	
func _process(delta):
	_show_jump_ray()
	pass
	
