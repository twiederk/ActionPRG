extends GutTest

const samurai_armor = preload("res://Items/Armor/SamuraiArmor.tres")

func test_action():

	# act
	samurai_armor.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.get_armor(), samurai_armor, "Should set armor to samurai armor")
