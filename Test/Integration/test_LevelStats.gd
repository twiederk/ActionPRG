extends GutTest


func test_get_set_current_level():

	# assert
	assert_accessors(LevelStats, "current_level", "Village", "Cave")


func test_visited_node():

	# arrange
	var node_path = NodePath("Village/YSort/Fixtures/SilverKey")

	# act
	LevelStats.visited_node(node_path)

	# assert
	var visited_nodes = LevelStats.get_visited_nodes()
	assert_eq(visited_nodes.size(), 1, "Should contain silver key")
	assert_eq(visited_nodes[0], "Village/YSort/Fixtures/SilverKey", "Should be path of silver_key")


func test_reset():
	
	# arrange
	LevelStats._visited_nodes["Village"] = [ "Node1", "Node2"]
	LevelStats._visited_nodes["Cave"] = [ "Node1", "Node2"]

	# act
	LevelStats.reset()
	
	# assert
	assert_eq(LevelStats._visited_nodes.size(), 0, "Should clear visited nodes")
	

