extends GutTest

var normal_door = null

func before_each():
	normal_door = NormalDoor.new()
	add_child(normal_door)


func after_each():
	normal_door.free()
	for child in get_children():
		child.free()


func test_can_open_door_not_Player():
	# arrange
	var body = double(KinematicBody2D).new()

	# act
	var result = normal_door._can_open_door(body)

	# assert
	assert_false(result, "Should not open door when body is not a player")


func test_can_open_door_Player_with_key():
	# arrange
	var body = double(Player).new()
	PlayerStats.set_key(Key.COPPER, 1)

	# act
	var result = normal_door._can_open_door(body)

	# assert
	assert_true(result, "Should open door when player has key")

	# tear down
	PlayerStats.set_key(Key.COPPER, 0)


func test_can_open_door_Player_no_key():
	# arrange
	var body = double(Player).new()

	# act
	var result = normal_door._can_open_door(body)

	# assert
	assert_false(result, "Should not open door when player has no key")


func test_open():

	# arrange
	watch_signals(normal_door)

	# act
	normal_door.open()

	# assert
	assert_signal_emitted_with_parameters(normal_door, "door_opened", [Vector2(0, 0)])


func test_is_missing_key_true():
	# arrange
	var body = double(Player).new()

	# act
	var result = normal_door._is_missing_key(body)

	# assert
	assert_true(result, "Should missing key when door is closed and no key carried by the player")
