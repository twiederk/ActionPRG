extends GutTest

func test_get_set_pickable():
	# arrange
	var weapon = Weapon.new()
	
	# assert
	assert_accessors(weapon, "pickable", true, false)
	
	# tear down
	weapon.free()
	
