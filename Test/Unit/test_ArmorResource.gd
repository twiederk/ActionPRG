extends GutTest


func test_action_equip_good_armor():

	# arrange
	var good_armor = ArmorResource.new()
	good_armor.armor_class = 5
	PlayerStats.set_armor(good_armor)

	var poor_armor = ArmorResource.new()
	poor_armor.armor_class = 1

	# act
	poor_armor.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.get_armor(), good_armor, "Should stay equipped with good armor")


func test_action_keep_good_armor():

	var good_armor = ArmorResource.new()
	good_armor.armor_class = 5

	var poor_armor = ArmorResource.new()
	poor_armor.armor_class = 1
	PlayerStats.set_armor(poor_armor)

	# act
	good_armor.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.get_armor(), good_armor, "Should equip good armor")
