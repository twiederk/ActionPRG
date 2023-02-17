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


func _on_SaveButton_pressed():
	get_node(Main.MAIN_NODE_PATH).save_game()


func _on_RestartButton_pressed():
	get_node(Main.MAIN_NODE_PATH).restart()
	close()


func _on_QuitButton_pressed():
	get_tree().quit()


