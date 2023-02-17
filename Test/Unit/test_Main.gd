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

	# act
	main.save_game(player)

	# assert
	assert_file_not_empty("user://savegame.save")
	var save_data = _get_lines("user://savegame.save")
	assert_eq(save_data.size(), 2, "Should contain one line per stored script")
	
	# tear down
	player.free()


func _get_lines(file_name: String) -> Array:
	var file = File.new()
	file.open(file_name, File.READ)
	var lines = []
	while file.get_position() < file.get_len():
		lines.append(file.get_line())
	file.close()
	return lines
