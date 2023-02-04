extends Node2D

export(float, 0.00, 1.00, 0.01) var rotation_speed = 1
enum Direction {CLOCKWISE = 1, COUNTERCLOCKWISE = -1}
export(Direction) var direction

#When corruption is 0, the planet is not being currently attached to a player.
export var corruption = 0
onready var rotationPlayer = get_node("RotationPlayer")
var _camera

# Called when the node enters the scene tree for the first time.
func _ready():
	rotationPlayer.playback_speed = 0.01 + rotationPlayer.playback_speed * rotation_speed * direction
	_camera = find_node("Camera2D")

func leave_planet():
	rotationPlayer.playback_active = false

func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Player":
		var player = area.get_parent()
		if corruption <= 0:
			corruption = 1
			
			player.planet = self
			var newpos = player.global_position
			get_parent().remove_child(player)
			add_child(player)
			
			_attach_camera(player.detach_camera())
			
			# new_parent.add_child(self)
			#set speed to 0?
			player._jump_speed = 0
			player.global_position = newpos
			print ("Planet corruption is ", corruption)
			
		
		print("Collided with '", self.name, "'!")
		pass

func _attach_camera(camera):
	_camera = camera
	add_child(_camera)
	
func detach_camera():
	remove_child(_camera)
	var camera = _camera
	_camera = null
	return camera
