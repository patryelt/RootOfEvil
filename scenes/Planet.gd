extends Node2D

export(float, 0.00, 1.00, 0.01) var rotation_speed = 1.0
enum Direction {CLOCKWISE = 1, COUNTERCLOCKWISE = -1}
export(Direction) var direction
export(int, 7) var planet_sprite

#When corruption is 0, the planet is not being currently attached to a player.
export var corruption = 0
onready var rotationPlayer = get_node("RotationPlayer")
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	rotationPlayer.playback_speed = 0.01 + rotationPlayer.playback_speed * rotation_speed * direction
	$Area2D/PlanetSprite/planet_anim.frame = planet_sprite
	

func leave_planet():
	rotationPlayer.playback_active = false

func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Player":
		var player = area.get_parent()
		if corruption <= 0:
			corruption = 1
			
			var newpos = player.global_position
			get_parent().remove_child(player)
			add_child(player)
			
			camera.target = self
			
			# new_parent.add_child(self)
			#set speed to 0?
			player.global_position = newpos
			player.land(self)
			print ("Planet corruption is ", corruption)
			
		
		print("Collided with '", self.name, "'!")
		pass
