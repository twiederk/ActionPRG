class_name GameOverUI
extends Control


func _ready():
	# warning-ignore-all:RETURN_VALUE_DISCARDED
	PlayerStats.connect("no_health", self, "show")



func _on_RestartButton_pressed():
	get_tree().change_scene("res://World/World.tscn")
	PlayerStats.reset()
