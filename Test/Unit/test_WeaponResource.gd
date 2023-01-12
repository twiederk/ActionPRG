extends GutTest

const wood_sword = preload("res://Resources/Weapons/WoodSword.tres")
const iron_sword = preload("res://Resources/Weapons/IronSword.tres")

func test_action():

	# act
	iron_sword.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.weapon, iron_sword, "Should set weapon to iron sword")


