class_name GamePauseUI
extends Control

onready var resumeButton = $ColorRect/ResumeButton


func _unhandled_input(event):
	if event.is_action_pressed("toggle_pause"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			open()
		else:
			close()
		get_tree().set_input_as_handled()

func open():
	show()
	resumeButton.grab_focus()


func close():
	get_tree().paused = false
	hide()


func _on_ResumeButton_pressed():
	close()


func _on_RestartButton_pressed():
	get_node(Main.MAIN_NODE_PATH).restart()
	get_tree().paused = false
	hide()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_SaveButton_pressed():
	var player = get_tree().get_nodes_in_group("player")[0]
	get_node(Main.MAIN_NODE_PATH).save_game("savegame", player)
