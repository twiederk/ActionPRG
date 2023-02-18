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


func save_game():
	var player = get_tree().get_nodes_in_group("player")[0]
	_save_game("savegame", player)


func _save_game(file_name: String, player: Player) -> void:
	var save_game = File.new()
	save_game.open(str("user://", file_name, ".save"), File.WRITE)
	var player_stats = PlayerStats.save()
	var player_postion = player.save()
	var level_stats = LevelStats.save()
	save_game.store_line(to_json(player_stats))
	save_game.store_line(to_json(player_postion))
	save_game.store_line(to_json(level_stats))
	save_game.close()


func load_game() -> void:
	var player_position = _load_game("savegame")
	goto_level(Village.NAME, player_position)


func _load_game(file_name: String) -> Vector2:
	var dictionaries = _load_dictionaries(file_name)
	var player_position = _load_player_position(dictionaries[1])
	return player_position


func _load_dictionaries(file_name) -> Array:
	var file = File.new()
	file.open(str("user://", file_name, ".save"), File.READ)
	var dictionaries = []
	while file.get_position() < file.get_len():
		dictionaries.append(parse_json(file.get_line()))
	file.close()
	return dictionaries


func _load_player_position(dict: Dictionary) -> Vector2:
	var pos_x = dict["player_position_x"]
	var pos_y = dict["player_position_y"]
	return Vector2(pos_x, pos_y)
