extends Node2D

var planet : Node2D
onready var jump_ray = $JumpRay
var _jump_direction = Vector2.ZERO
var _jump_speed = 0


func _ready():
	planet = get_parent()

func _get_jump_direction():
	var up_direction = self.position.normalized()
	var forward_direction = Vector2(up_direction.y, up_direction.x)
	if planet.direction == 1:
		forward_direction.x = -forward_direction.x
	else:
		forward_direction.y = -forward_direction.y
	return up_direction.linear_interpolate(forward_direction, planet.rotation_speed)

func _jump():
	# TODO: Fix _jump_direction!
	_jump_direction = _get_jump_direction()
	_jump_speed = 300 + planet.rotation_speed * 1000
	planet = null
	var player_global_position = global_position
	var player_global_rotation = global_rotation
	var game_node = get_parent().get_parent()
	get_parent().remove_child(self)
	game_node.add_child(self)
	global_position = player_global_position
	global_rotation = player_global_rotation
	jump_ray.set_point_position(1, Vector2.ZERO)

func _show_jump_ray():
	var jump_direction = _get_jump_direction()
	jump_ray.set_point_position(1, jump_direction * 1000)
	
func _process(delta):
	if planet == null:
		position += _jump_direction * delta * _jump_speed
	else:
		_show_jump_ray()
	if Input.is_action_just_pressed("jump"):
		_jump()

