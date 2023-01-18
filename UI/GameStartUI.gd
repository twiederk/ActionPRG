class_name GameStartUI
extends Control

onready var versionLabel = $ColorRect/VersionLabel
onready var startButton = $ColorRect/StartButton

func _ready():
	show()
	get_tree().paused = true
	versionLabel.text = get_version()
	startButton.grab_focus()


func get_version() -> String:
	return ProjectSettings.get_setting("application/config/description")


func _on_StartButton_pressed():
	get_tree().paused = false
	hide()


func _on_QuitButton_pressed():
	get_tree().quit()
