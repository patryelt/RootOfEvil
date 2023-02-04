extends Node2D

var planet : Node2D
var _camera : Camera2D
var _jump_direction = Vector2.ZERO
var _jump_speed = 0


func _ready():
	planet = get_parent()

func _get_jump_direction():
	var up_direction = (global_position - planet.global_position).normalized()
	return up_direction

func _jump():
	_jump_direction = _get_jump_direction()
	_jump_speed = 300 + planet.rotation_speed * 1000
	
	# Move camera from following the planet to following the player
	_attach_camera(planet.detach_camera())
	
	planet.leave_planet()
	planet = null
	var player_global_position = global_position
	var player_global_rotation = global_rotation
	var game_node = get_parent().get_parent()
	
	get_parent().remove_child(self)
	game_node.add_child(self)
	global_position = player_global_position
	global_rotation = player_global_rotation

	
func _process(delta):
	if planet == null:
		position += _jump_direction * delta * _jump_speed
	if Input.is_action_just_pressed("jump") and planet:
		_jump()
		
func _attach_camera(camera):
	_camera = camera
	add_child(_camera)
	
func detach_camera():
	remove_child(_camera)
	var camera = _camera
	_camera = null
	return camera
