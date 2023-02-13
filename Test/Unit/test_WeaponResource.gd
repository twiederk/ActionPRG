extends GutTest


func test_action_equip_good_weapon():
	
	# arrange
	var good_weapon = WeaponResource.new()
	good_weapon.damage_die = Die.Name.D8
	
	var poor_weapon = WeaponResource.new()
	poor_weapon.damage_die = Die.Name.D4
	PlayerStats.set_weapon(poor_weapon)

	# act
	good_weapon.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.get_weapon(), good_weapon, "Should keep good weapon equipped")


func test_action_keep_good_weapon():
	
	# arrange
	var good_weapon = WeaponResource.new()
	good_weapon.damage_die = Die.Name.D8
	PlayerStats.set_weapon(good_weapon)
	
	var poor_weapon = WeaponResource.new()
	poor_weapon.damage_die = Die.Name.D4

	# act
	poor_weapon.action(PlayerStats)

	# assert
	assert_eq(PlayerStats.get_weapon(), good_weapon, "Should keep good weapon equipped")

