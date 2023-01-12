extends GutTest

func test_action():
	# arrange
	var gold_key = load("res://Resources/Keys/GoldKey.tres")

	# act
	gold_key.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.key_gold, 1, "Should add one gold key")



