extends GutTest

var treasure_chest: TreasureChest = null

func before_each():
	treasure_chest = TreasureChest.new()


func after_each():
	treasure_chest.free()


func test_can_be_opened_no_key():
	# act
	var result = treasure_chest.can_be_opened(0)
	
	# assert
	assert_false(result, "Should not be opend without a key")


func test_can_be_opened_already_opened():
	# arrange
	treasure_chest.treasure_state = TreasureChest.TreasureState.OPEN
	
	# act
	var result = treasure_chest.can_be_opened(1)
	
	# assert
	assert_false(result, "Should not be opend when already opened")


func test_can_be_opened_with_key_and_closed():
	
	# act
	var result = treasure_chest.can_be_opened(1)
	
	# assert
	assert_true(result, "Should open when closed and key is available")


func test_is_missing_key_no_key():
	
	# act
	var result = treasure_chest.is_missing_key(0)
	
	# assert
	assert_true(result, "Should missing key when no key is available and is still closed")



func test_is_missing_key_already_open():
	# arrange
	treasure_chest.treasure_state = TreasureChest.TreasureState.OPEN

	# act
	var result = treasure_chest.is_missing_key(1)
	
	# assert
	assert_false(result, "Should not missing key when already open")
