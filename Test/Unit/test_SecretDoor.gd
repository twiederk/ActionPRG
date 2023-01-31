extends GutTest

var secret_door = null

func before_each():
	secret_door = SecretDoor.new()
	add_child(secret_door)


func after_each():
	secret_door.free()
	for child in get_children():
		child.free()


func test_on_SecretDoor_area_entered():
	
	# arrange
	watch_signals(secret_door)
	var area2D = Area2D.new()

	# act
	secret_door._on_SecretDoor_area_entered(area2D)

	# assert
	assert_signal_not_emitted(secret_door, "door_opened")
	
	# tear down
	area2D.free()


func test_on_SecretDoor_area_entered_with_PlayerHitbox():

	# arrange
	watch_signals(secret_door)
	var player_hitbox = PlayerHitbox.new()

	# act
	secret_door._on_SecretDoor_area_entered(player_hitbox)

	# assert
	assert_signal_emitted(secret_door, "door_opened")
	
	# tear down
	player_hitbox.free()


func test_open():
	
	# arrange
	watch_signals(secret_door)
	
	# act
	secret_door.open()
	
	# assert
	assert_signal_emitted_with_parameters(secret_door, "door_opened", [Vector2(0, 0)])
