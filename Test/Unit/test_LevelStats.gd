extends GutTest

var level_stats: LvlStats = null

func before_each():
	level_stats = LvlStats.new()


func after_each():
	level_stats.free()


func test_get_set_current_level():

	# assert
	assert_accessors(level_stats, "current_level", "Village", "Cave")


func test_visited_node():

	# arrange
	var node_path = NodePath("Village/YSort/Fixtures/SilverKey")

	# act
	level_stats.visited_node(node_path)

	# assert
	var visited_nodes = level_stats.get_visited_nodes()
	assert_eq(visited_nodes.size(), 1, "Should contain silver key")
	assert_eq(visited_nodes[0], "Village/YSort/Fixtures/SilverKey", "Should be path of silver_key")


func test_reset():

	# arrange
	level_stats._visited_nodes["Village"] = [ "Node1", "Node2"]
	level_stats._visited_nodes["Cave"] = [ "Node1", "Node2"]

	# act
	level_stats.reset()

	# assert
	assert_eq(level_stats._visited_nodes.size(), 0, "Should clear visited nodes")


func test_save():

	# arrange
	level_stats._visited_nodes["Village"] = [ "Node1", "Node2"]
	level_stats._visited_nodes["Cave"] = [ "Node1", "Node2"]
	level_stats.set_current_level("Cave")

	# act
	var save_data = level_stats.save()

	# assert
	assert_eq(save_data["current_level"], "Cave", "Should store current level in save data")
	assert_eq(save_data["visited_nodes"].size(), 2, "Should store visited nodes dictionary in save data")
