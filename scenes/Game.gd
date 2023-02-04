extends Node2D

var _planet_scene = preload("res://scenes/Planet.tscn")
onready var camera_2d = $Camera2D
var _planets = []
var _y_pos = 0
var _y_planet_space = 1200

func _ready():
	var start_planet = $StartPlanet
	var camera = $Camera2D
	start_planet.camera = camera
	$StartPlanet/Player.camera = camera
	camera.target = start_planet
	_planets.push_back(start_planet)
	spawn_planet()
	spawn_planet()

func spawn_planet(offset = 0, shift_world=false):
	_y_pos += _y_planet_space
	var new_planet = _planet_scene.instance()
	new_planet.rotation_speed = 0.4
	new_planet.camera = camera_2d
	add_child(new_planet)
	var base_position = Vector2(200, -_y_pos)
	new_planet.position = base_position
	if _planets.size() > 3:
		remove_child(_planets[0])
		var temp_planets = _planets
		_planets = []
		_planets.push_back(temp_planets[1])
		_planets.push_back(temp_planets[2])
	_planets.push_back(new_planet)
