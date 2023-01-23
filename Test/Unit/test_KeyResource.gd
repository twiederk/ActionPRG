extends GutTest

func test_action():
	# arrange
	var gold_key = load("res://Items/Keys/GoldKey.tres")

	# act
	gold_key.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.get_key(Key.GOLD), 1, "Should add one gold key")



