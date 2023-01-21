extends GutTest


func test_MAIN_PATH():

	# act
	var main_path = Main.MAIN_NODE_PATH

	# assert
	assert_eq(main_path, "/root/Main", "Should always point to Main node")
