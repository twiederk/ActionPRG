extends GutTest

var door: Door = null

func before_each():
	door = Door.new()


func after_each():
	door.free()


func test_get_set_opened():
	# arrange
	door.collisionShape = CollisionShape2D.new()
	
	# assert
	assert_accessors(door, "opened", false, true)
	
	# tear down
	door.collisionShape.free()


func test_can_open_door_not_Player():
	# arrange
	var body = double(KinematicBody2D).new()

	# act
	var result = door.can_open_door(body, 1)

	# assert
	assert_false(result, "Should not open door when body is not a player")


func test_can_open_door_Player_with_key():
	# arrange
	var body = double(Player).new()

	# act
	var result = door.can_open_door(body, 1)

	# assert
	assert_true(result, "Should open door when player has key")


func test_can_open_door_Player_no_key():
	# arrange
	var body = double(Player).new()

	# act
	var result = door.can_open_door(body, 0)

	# assert
	assert_false(result, "Should not open door when player has no key")


func test_can_open_door_Door_open():
	# arrange
	var body = double(Player).new()
	door._opened = true

	# act
	var result = door.can_open_door(body, 1)

	# assert
	assert_false(result, "Should not open door when door is already open")


func test_is_missing_key_true():
	# arrange
	var body = double(Player).new()

	# act
	var result = door.is_missing_key(body, 0)

	# assert
	assert_true(result, "Should missing key when door is closed and no key carried by the player")
