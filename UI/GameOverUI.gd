class_name GameOverUI
extends Control


func _ready():
	# warning-ignore-all:RETURN_VALUE_DISCARDED
	PlayerStats.connect("no_health", self, "show")



func _on_RestartButton_pressed():
	var main = get_node("/root/Main")
	main.goto_level("Village")
	PlayerStats.reset()
	hide()
	
