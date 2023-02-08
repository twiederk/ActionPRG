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

	# act
	main._handle_visited_node(normal_door)
	
	# assert
	assert_called(normal_door, "open")

	# tear down
	normal_door.free()


func test_handle_visited_node_secret_door():
	
	# arrange
	var secret_door = double(SecretDoor).new()

	# act
	main._handle_visited_node(secret_door)
	
	# assert
	assert_called(secret_door, "open")

	# tear down
	secret_door.free()
