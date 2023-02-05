extends Node2D

var _planet_scene = preload("res://scenes/Planet.tscn")
var _wormhole_scene = preload("res://scenes/Wormhole.tscn")
var _player_scene = preload("res://scenes/Player/Player.tscn")
onready var player_vars = get_node("/root/PlayerVariables")

onready var camera_2d = $Camera2D
var _planets = []
var _y_pos = 0
var _y_planet_space = 1200
var _x_planet_space = 500
var _stage_score = 0
var _stage_speed = 0.15
var stage = 1
var current_dialogue
var tutorial1_has_called:bool
var tutorial2_has_called:bool
var first_planet_spawned:bool
var earth_planet_spawned:bool


var rng = RandomNumberGenerator.new()

func _ready():
	# Temporarily disabled due to blocking input	
#	var dialogic_start = Dialogic.start('start')
#	add_child(dialogic_start)
	initialize()

func spawn_planet():
	print(player_vars.score)
	_y_pos += _y_planet_space
	var new_planet = _planet_scene.instance()
	rng.randomize()
	var random_speed = rng.randf_range(0.9,1.1)
	var random_offset = rng.randf_range(1, 2)
	new_planet.camera = camera_2d
	new_planet.rotation_speed = _stage_speed * random_speed
	if stage > 1 and rng.randf() > 0.5:
		new_planet.direction = -1
	
	new_planet.planet_sprite = floor(rng.randf() * 5)
	if (player_vars.score == 0 and !first_planet_spawned):
		new_planet.planet_sprite = 7
		first_planet_spawned = true
	if (player_vars.score == 17 and !earth_planet_spawned):
		new_planet.planet_sprite = 6
		new_planet.rotation_speed = 0.05
		new_planet.rotation = -3
		earth_planet_spawned = true
		
	add_child(new_planet)
	var random_x_offset = random_offset * _x_planet_space - _x_planet_space / 2;
	var base_position = Vector2(200 + random_x_offset, -_y_pos)
	
	new_planet.position = base_position
	if _planets.size() > 3:
		remove_child(_planets[0])
		var temp_planets = _planets
		_planets = []
		_planets.push_back(temp_planets[1])
		_planets.push_back(temp_planets[2])
	_planets.push_back(new_planet)
	
func initialize():
	first_planet_spawned = false
	player_vars.score = 0
	_stage_score = 0
	_stage_speed = 0.15
	spawn_planet()
	spawn_planet()
	spawn_planet()
	var player = _player_scene.instance()
	player.connect("drifting_endlessly", self, "_on_Player_drifting_endlessly")
	player.connect("landing_on_planet", self, "_on_Player_landing_on_planet")
	player.camera = camera_2d
	var start_planet = _planets[0]
	player._planet = start_planet
	start_planet.add_child(player)
	camera_2d.target = start_planet
	player.translate(Vector2(0,-480))
	camera_2d.position = start_planet.position
	
func _on_Player_drifting_endlessly(player):
	camera_2d.target = null
	camera_2d.position = Vector2(0,0)
	get_tree().change_scene("res://scenes/deathmenu.tscn")
	
func _on_Player_landing_on_planet():
	player_vars.score += 1
	_stage_score +=1
	if (_stage_score > 1):
		stage += 1
		_stage_score = 0
		_stage_speed += 0.05
		print("STAGE ", stage, "\n Speed is now: ", _stage_speed)
	# Temporarily disabled due to blocking input
#	trigger_dialogue()
	spawn_planet()
	
func spawn_wormhole():
	
	pass
	
func trigger_dialogue():
	var random_dialogue = rng.randi_range(0, 9)
	print(random_dialogue)
	
	
	if(is_instance_valid(current_dialogue)):
		current_dialogue.queue_free()
	
	# DIALOGUES
	if (player_vars.score == 1 and !tutorial1_has_called):
		current_dialogue = Dialogic.start('first_jump')
		add_child(current_dialogue)
		tutorial1_has_called = true
	if (player_vars.score == 2 and !tutorial2_has_called):
		current_dialogue = Dialogic.start('second_jump')
		add_child(current_dialogue)
		tutorial2_has_called = true
		
	if (player_vars.score % 4 == 0):
		pass
	
	
	
