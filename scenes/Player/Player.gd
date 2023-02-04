extends Node2D

var _planet : Node2D
var camera : Camera2D
var _jump_direction = Vector2.ZERO
var _jump_speed = 0
onready var player_anim = $player_anim


func _ready():
	_planet = get_parent()

func _get_jump_direction():
	var up_direction = (global_position - _planet.global_position).normalized()
	return up_direction

func _jump():
	_jump_direction = _get_jump_direction()
	_jump_speed = 300 + _planet.rotation_speed * 1000
	
	# Leave body behind
	var old_body = player_anim.duplicate()
	player_anim.jump()
	old_body.leave()
	_planet.add_child(old_body)
	old_body.position = position
	old_body.rotation = rotation
	
	camera.target = self
	
	_planet.leave_planet()
	_planet = null
	var player_global_position = global_position
	var player_global_rotation = global_rotation
	var game_node = get_parent().get_parent()
	
	get_parent().remove_child(self)
	game_node.add_child(self)
	global_position = player_global_position
	global_rotation = player_global_rotation
	

func land(planet):
	_planet = planet
	_jump_speed = 0
	look_at(planet.position)
	rotate(-PI/2)
	grow()
	
func grow():
	translate(position.normalized() * 200)
	player_anim.grow()

	
func _process(delta):
	if _planet == null:
		position += _jump_direction * delta * _jump_speed
	if Input.is_action_just_pressed("jump") and _planet:
		player_anim.initiate_animation()
