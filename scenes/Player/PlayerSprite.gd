extends Node2D

func leave():
	$eye_anim.hide()

func jump():
	$stem.hide()
	$flower_anim.hide()

func grow():
	$stem.show()
	$flower_anim.show()
