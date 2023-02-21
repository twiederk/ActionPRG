extends GutTest

var main: Main = null


func before_each():
	main = Main.new()


func after_each():
	main.free()


func test_MAIN_PATH():

	# act
	var main_path = Main.MAIN_NODE_PATH

	# assert
	assert_eq(main_path, "/root/Main", "Should always point to Main node")


func test_handle_visited_node():

	# arrange
	var node = double(Node2D).new()

	# act
	main._handle_visited_node(node)

	# assert
	assert_called(node, "queue_free")


func test_handle_visited_node_null():

	# act
	main._handle_visited_node(null)

	# assert
	assert_true(true, "Should not crash when node is null")


func test_handle_visited_node_normal_door():

	# arrange
	var normal_door = double(NormalDoor).new()
	stub(normal_door, "open")

	# act
	main._handle_visited_node(normal_door)

	# assert
	assert_called(normal_door, "open", [])

	# tear down
	normal_door.free()


func test_handle_visited_node_secret_door():

	# arrange
	var secret_door = double(SecretDoor).new()
	stub(secret_door, "open")

	# act
	main._handle_visited_node(secret_door)

	# assert
	assert_called(secret_door, "open", [])

	# tear down
	secret_door.free()


func test_save_game():

	# arrange
	var player = Player.new()
	PlayerStats.set_weapon(PlayerStats.DEFAULT_WEAPON)
	PlayerStats.set_armor(PlayerStats.DEFAULT_ARMOR)

	# act
	main._save_game("test_save_game", player)

	# assert
	assert_file_exists("user://test_save_game.save")
	assert_file_not_empty("user://test_save_game.save")
	var save_data = _get_lines("user://test_save_game.save")
	assert_eq(save_data.size(), 3, "Should contain one line per stored script")

	# tear down
	player.free()
	_delete_file("test_save_game.save")


func test_load_game():

	# arrange
	var player = Player.new()
	player.position = Vector2(20, 20)
	main._save_game("test_load_game", player)

	# act
	var loaded_game = main._load_game("test_load_game")

	# assert
	assert_eq(loaded_game["player_position"], Vector2(20, 20), "Should return the player position")
	assert_eq(loaded_game["current_level"], "Village", "Should return the current level")

	# tear down
	player.free()
	_delete_file("test_load_game.save")


func _get_lines(file_name: String) -> Array:
	var file = File.new()
	file.open(file_name, File.READ)
	var lines = []
	while file.get_position() < file.get_len():
		lines.append(file.get_line())
	file.close()
	return lines


func _delete_file(file_name: String) -> void:
	var dir = Directory.new()
	dir.open("user://")
	dir.remove(file_name)
