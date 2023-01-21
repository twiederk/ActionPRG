extends Node

var _visited_nodes = {}
var _current_level = "Village"


func get_current_level() -> String:
	return _current_level


func set_current_level(level_name: String) -> void:
	_current_level = level_name


func visited_node(path: NodePath) -> void:
	var visited_nodes = get_visited_nodes()
	visited_nodes.append(str(path))


func get_visited_nodes(level_name: String = _current_level) -> Array:
	if not level_name in _visited_nodes:
		_visited_nodes[_current_level] = []
	return _visited_nodes[level_name]

