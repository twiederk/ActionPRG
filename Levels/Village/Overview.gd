class_name Overview
extends Node2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("overview"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			show_overview()
		else:
			hide_overview()
		get_viewport().set_input_as_handled()


func show_overview():
	var player = get_tree().get_nodes_in_group("player")[0]
	position = player.position
	show()


func hide_overview():
	hide()
	position = Vector2(-100, -100)
