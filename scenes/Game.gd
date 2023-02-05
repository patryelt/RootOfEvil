extends Node2D


var _planet_scene = preload("res://scenes/Planet.tscn")
var _player_scene = preload("res://scenes/Player/Player.tscn")
onready var camera_2d = $Camera2D
onready var score_counter = $Camera2D/ScoreCounter 
var _planets = []
var _y_pos = 0
var _y_planet_space = 1200
var _x_planet_space = 500
var _score = 0
var _stage_score = 0
var _stage_speed = 0.15
var stage = 1

var rng = RandomNumberGenerator.new()

func _ready():
	initialize()

func spawn_planet():
	
	_y_pos += _y_planet_space
	var new_planet = _planet_scene.instance()
	rng.randomize()
	var random_speed = rng.randf_range(0.9,1.1)
	var random_offset = rng.randf_range(1, 2)
	new_planet.camera = camera_2d
	new_planet.planet_sprite = floor(rng.randf() * 8)
	new_planet.rotation_speed = _stage_speed * random_speed
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
	
func _update_score_label():
	score_counter.text = "Score: " + str(_score)

func initialize():
	_score = 0
	_stage_score = 0
	_stage_speed = 0.15
	spawn_planet()
	spawn_planet()
	spawn_planet()
	_update_score_label()
	var player = _player_scene.instance()
	player.connect("drifting_endlessly", self, "_on_Player_drifting_endlessly")
	player.connect("landing_on_planet", self, "_on_Player_landing_on_planet")
	player.camera = camera_2d
	var start_planet = _planets[0]
	player._planet = start_planet
	start_planet.add_child(player)
	camera_2d.target = start_planet
	player.translate(Vector2(0,-380))
	camera_2d.position = start_planet.position
	
	
func _on_Player_drifting_endlessly(player):
	print("hej")
	remove_child(player)
	for planet in _planets:
		remove_child(planet)
	_planets = []
	initialize()
	
func _on_Player_landing_on_planet():
	_score += 1
	_stage_score +=1
	if (_stage_score > 1):
		stage += 1
		_stage_score = 0
		_stage_speed += 0.05
		print("STAGE ", stage, "\n Speed is now: ", _stage_speed)
	_update_score_label()
	spawn_planet()
	
