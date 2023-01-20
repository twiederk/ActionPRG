class_name Main
extends Node

var current_level = "Village"

func goto_level(level_name: String, starting_position: Vector2) -> void:
	call_deferred("_deferred_goto_level", level_name, starting_position)


func _deferred_goto_level(level_name: String, starting_position: Vector2) -> void:
	get_node(str("/root/Main/", current_level)).free()
	var Level = load(str("res://Levels/", level_name, "/", level_name, ".tscn"))
	current_level = level_name
	var level = Level.instance()
	add_child(level)
	get_tree().call_group("player", "set_starting_position", starting_position)
	
	


