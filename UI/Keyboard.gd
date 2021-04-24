extends Node2D

export(bool) var showKeyboard = false

func _ready():
	if OS.get_name() == "Android":
		showKeyboard = true
	set_visible(showKeyboard)

func _physics_process(delta):
	if Input.is_action_just_pressed("keyboard"):
		showKeyboard = !showKeyboard
		set_visible(showKeyboard)
		
