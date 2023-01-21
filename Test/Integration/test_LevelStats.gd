extends GutTest


func test_get_set_current_level():

	# assert
	assert_accessors(LevelStats, "current_level", "Village", "Cave")


func test_visited_node():

	# arrange
	var node_path = NodePath("Village/YSort/Fixtures/CopperKey")

	# act
	LevelStats.visited_node(node_path)

	# assert
	var visited_nodes = LevelStats.get_visited_nodes()
	assert_eq(visited_nodes.size(), 1, "Should contain copper key")
	assert_eq(visited_nodes[0], "Village/YSort/Fixtures/CopperKey", "Should be path of copper_key")





