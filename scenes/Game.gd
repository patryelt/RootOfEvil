extends Node2D
var planet = preload("res://scenes/Planet.tscn")


var zone
onready var topZoneNode = $SpawnZoneTop
onready var midZoneNode = $SpawnZoneMid
onready var botZoneNode = $SpawnZoneBot


# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn_planet(topZone)
	spawn_planet(2)
	spawn_planet(1)

func spawn_planet(zone):
	var new_planet = planet.instance()
	add_child(new_planet)
	var new_position
	
	
	
	# Set planet zone to relevant one
	new_planet.zone = zone
	match zone:
		1:
			new_position = botZoneNode.position
			new_planet.name = "PlanetBot"
			new_planet.rotationPlayer.playback_speed = 0.1
			
		2:
			new_position = midZoneNode.position
			new_planet.name = "PlanetMid"
			new_planet.rotationPlayer.playback_speed = 0.5
		3:
			new_position = topZoneNode.position
			new_planet.name = "PlanetTop"
			new_planet.rotationPlayer.playback_speed = -0.5
	
	print(new_planet, " is in zone ", zone)
	new_planet.global_position = new_position
	new_planet.global_position.x += rand_range(-200, 500)
	
	
	

func get_planet(zone):
	var value
	match zone:
		1:
			value = find_node("PlanetBot")
		2:
			value = find_node("PlanetMid")
		3:
			value = find_node("PlanetTop")
		_:
			print("GET failed")
	print("GETTING ", value, " HAS ZONE ", zone)
	return value

func remove_planet(zone):
	var value = get_planet(zone)
	print("REMOVING ", value, " HAS ZONE ", zone)
	value.queue_free()
	pass

func move_planet(fromZone, toZone):
	
	var planetFrom = get_planet(fromZone)
	var planetTo = get_planet(toZone)
	print("MOVING ", planetFrom, " TO ", planetTo)
	planetFrom.position = planetTo.position
	
	var new_name = planetTo.name
	var new_zone = planetTo.zone
	remove_planet(toZone)
	planetFrom.zone = new_zone
	planetFrom.name = new_name
	
	# planetFrom.zone = planetTo.zone
	# planetFrom.name = planetTo.name


# player is at planet 1, goes to planet 2. planet 1 despawns. planet 3 goes to planet 2. planet 2 goes to planet 1. repeat
