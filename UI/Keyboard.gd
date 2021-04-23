extends Node2D

var showKeyboard = true

func _physics_process(delta):
	if Input.is_action_just_pressed("keyboard"):
		showKeyboard = !showKeyboard
		set_visible(showKeyboard)
		
