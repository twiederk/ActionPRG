extends GutTest

const iron_sword = preload("res://Items/Weapons/Sword.tres")

func test_action():

	# act
	iron_sword.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.get_weapon(), iron_sword, "Should set weapon to iron sword")
