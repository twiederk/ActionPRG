class_name Main
extends Node

const MAIN_NODE_PATH = "/root/Main"


func restart():
	goto_level(Village.NAME, Village.STARTING_POSITION)
	PlayerStats.reset()
	LevelStats.reset()


func goto_level(level_name: String, starting_position: Vector2) -> void:
	call_deferred("_deferred_goto_level", level_name, starting_position)


func _deferred_goto_level(level_name: String, starting_position: Vector2) -> void:
	_free_current_level()
	_load_level(level_name)
	_free_visited_nodes()
	get_tree().call_group("player", "set_starting_position", starting_position)


func _free_current_level():
	var level_node_path = str(MAIN_NODE_PATH, "/", LevelStats.get_current_level())
	get_node(level_node_path).free()


func _load_level(level_name: String) -> void:
	var Level = load(str("res://Levels/", level_name, "/", level_name, ".tscn"))
	var level = Level.instance()
	add_child(level)
	LevelStats.set_current_level(level_name)


func _free_visited_nodes() -> void:
	var visited_nodes = LevelStats.get_visited_nodes()
	for node_path in visited_nodes:
		var visited_node = get_node_or_null(node_path)
		_handle_visited_node(visited_node)


func _handle_visited_node(visited_node: Node) -> void:
	if visited_node == null:
		pass
	elif visited_node is SecretDoor or visited_node is NormalDoor:
		visited_node.open()
	else:
		visited_node.queue_free()

