extends GutTest

func test_get_set_pickable():
	# arrange
	var item = Item.new()

	# assert
	assert_accessors(item, "pickable", true, false)

	# tear down
	item.free()

