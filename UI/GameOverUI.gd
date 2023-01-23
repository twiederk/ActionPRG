class_name GameOverUI
extends Control

onready var restartButton = $ColorRect/RestartButton

func _ready():
	# warning-ignore-all:RETURN_VALUE_DISCARDED
	PlayerStats.connect("no_health", self, "show")


func _on_RestartButton_pressed():
	get_node(Main.MAIN_NODE_PATH).restart()
	hide()

