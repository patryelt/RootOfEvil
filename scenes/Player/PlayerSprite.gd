extends Node2D

onready var burst_animationplayer = $burst_animationplayer

func initiate_animation():
	burst_animationplayer.play("Trigger Projectile")

func leave():
	
	# $eye_anim.hide()
	# $eye_burst.frame = 3
	# $eye_burst.show()
	pass

func jump():
	$stem.hide()
	$flower_anim.hide()
	$eye_anim.hide()
	$eye_burst.hide()
	$projectile.show()

func grow():
	$stem.show()
	$flower_anim.show()
	$projectile.hide()
	$eye_anim.show()

func trigger_jump():
	get_parent()._jump()
	
