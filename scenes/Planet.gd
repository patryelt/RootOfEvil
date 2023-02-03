extends Node2D

export(float, 0.00, 1.00, 0.01) var rotation_speed = 1
enum Direction {CLOCKWISE = 1, COUNTERCLOCKWISE = -1}
export(Direction) var direction

#When corruption is 0, the planet is not being currently attached to a player.
export var corruption = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	$RotationPlayer.playback_speed = 0.01 + $RotationPlayer.playback_speed * rotation_speed * direction

func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Player":
		var player = area.get_parent()
		if corruption <= 0:
			player.planet = self
			var newpos = player.global_position
			get_parent().remove_child(player)
			add_child(player)
			
			# new_parent.add_child(self)
			corruption = 1
			#set speed to 0?
			player._jump_speed = 0
			player.global_position = newpos
		
		
		
		
		
		print("Collided with '", self.name, "'!")
		pass
