extends Node2D

func leave():
	$eye_anim.hide()
	$socket_anim.show()

func jump():
	$stem.hide()
	$flower_anim.hide()
	$eye_anim.hide()
	$projectile.show()

func grow():
	$stem.show()
	$flower_anim.show()
	$projectile.hide()
	$eye_anim.show()

