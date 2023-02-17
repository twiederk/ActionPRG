extends 'res://addons/gut/test.gd'

var stats : Stats = null;


func before_each():
	stats = Stats.new();


func after_each():
	stats.free();


func test_init():
	# assert
	assert_eq(stats.get_max_health(), 6, "Should start with max health of 10")
	assert_eq(stats.get_health(), 6, "Should start with health of 10")
	assert_eq(stats.get_strength(), 0, "Should start with strength of 0")
	assert_eq(stats.get_experience_points(), 0, "Should start with experience points of 0")
	assert_eq(stats.get_level(), 1, "Should start with level of 1")
	assert_eq(stats.get_weapon(), Stats.DEFAULT_WEAPON, "Should start with default weapon")
	assert_eq(stats.get_armor(), Stats.DEFAULT_ARMOR, "Should start with default armor")


func test_total_heal():
	# arrange
	stats.set_health(0);
	watch_signals(stats)

	# act
	stats.total_heal();

	# assert
	assert_eq(stats.get_health(), stats.get_max_health(), "Should set health to max when stats is totally healed");
	assert_signal_emitted(stats, "health_changed")


func test_heal():
	# arrange
	stats.set_health(0);
	watch_signals(stats)

	# act
	stats.heal();

	# assert
	assert_eq(stats.get_health(), 1, "Should increase health by 1 when stats is healed");
	assert_signal_emitted(stats, "health_changed")


func test_heal_more_than_max_health():
	# arrange
	stats.heal(5)

	# assert
	assert_eq(stats.get_health(), 6, "Should not exceed max health when healed")


func test_get_damage():

	# arrange
	seed(1)

	# act
	var damage = stats.get_damage()

	# assert
	assert_eq(damage, 2, "Should be damage of Dagger")


func test_get_damage_with_strength_1():

	# arrange
	seed(1)
	stats.increase_strength()

	# act
	var damage = stats.get_damage()

	# assert
	assert_eq(damage, 3, "Should be damage of Dagger and strength")


func test_hurt():

	# arrange
	stats.set_health(10)
	watch_signals(stats)

	# act
	stats.hurt(3)

	# assert
	assert_eq(stats.get_health(), 7, "Should reduce health by damage")
	assert_signal_emitted(stats, "health_changed")


func test_hurt_armor_class_lower_than_hit_damage():

	# arrange
	stats.set_health(10)
	var armor = ArmorResource.new()
	armor.armor_class = 1
	stats.set_armor(armor)

	# act
	stats.hurt(3)

	# assert
	assert_eq(stats.get_health(), 8, "Should reduce health by damage minus armor class")


func test_hurt_armor_class_higher_than_hit_damage():

	# arrange
	stats.set_health(10)
	var armor = ArmorResource.new()
	armor.armor_class = 5

	stats.set_armor(armor)

	# act
	stats.hurt(3)

	# assert
	assert_eq(stats.get_health(), 9, "Should reduce health by 1 when armor class is higher than damage")


func test_reset():

	# arrange
	stats.set_max_health(20)
	stats.set_health(10)
	stats.set_strength(10)
	stats.increase_key(Key.GOLD)
	stats.increase_key(Key.SILVER)
	stats.set_weapon(null)
	stats.set_armor(null)
	stats.set_experience_points(10)
	watch_signals(stats)

	# act
	stats.reset()

	# assert
	assert_eq(stats.get_max_health(), Stats.MAX_HEALTH, "Should reset health")
	assert_eq(stats.get_health(), Stats.MAX_HEALTH, "Should reset health")
	assert_eq(stats.get_strength(), 0, "Should reset strength")
	assert_eq(stats.get_experience_points(), 0, "Should reset experience points")
	assert_eq(stats.get_level(), 1, "Should reset level")
	assert_eq(stats.get_key(Key.GOLD), 0, "Should reset keys gold")
	assert_eq(stats.get_key(Key.SILVER), 0, "Should reset keys silver")
	assert_eq(stats.get_key(Key.BRONZE), 0, "Should reset keys bronze")
	assert_eq(stats.get_weapon(), Stats.DEFAULT_WEAPON, "Should reset weapon")
	assert_eq(stats.get_armor(), Stats.DEFAULT_ARMOR, "Should reset armor")

	assert_signal_emitted(stats, "max_health_changed", "Should emit max_health_changed signal")
	assert_signal_emitted(stats, "health_changed", "Should emit health_changed signal")
	assert_signal_emitted(stats, "weapon_changed", "Should emit weapon_changed signal")
	assert_signal_emitted(stats, "armor_changed", "Should emit armor_changed signal")
	assert_signal_emit_count(stats, "key_changed", 6, "Should emit key_changed signal two times")


func test_player_dies():

	#arrange
	watch_signals(stats)

	# act
	stats.hurt(20)

	# assert
	assert_eq(stats.get_health(), 0, "Should set hit points never be lower than 0")
	assert_signal_emitted(stats, "health_changed")
	assert_signal_emitted(stats, "no_health")


func test_set_max_health():

	# arrange
	watch_signals(stats)

	# act
	stats.set_max_health(20)

	# assert
	assert_eq(stats.get_max_health(), 20, "Should set max health properly")
	assert_signal_emitted(stats, "max_health_changed")


func test_increase_key_silver() -> void:

	# arrange
	stats._keys[Key.SILVER] = 0
	watch_signals(stats)

	# act
	stats.increase_key(Key.SILVER)

	# assert
	assert_eq(stats.get_key(Key.SILVER), 1, "Should increase silver key by one")
	assert_signal_emitted(stats, "key_changed")


func test_increase_key_gold() -> void:

	# arrange
	stats._keys[Key.GOLD] = 0
	watch_signals(stats)

	# act
	stats.increase_key(Key.GOLD)

	# assert
	assert_eq(stats.get_key(Key.GOLD), 1, "Should increase gold key by one")
	assert_signal_emitted(stats, "key_changed")


func test_decrease_key_silver() -> void:

	# arrange
	stats._keys[Key.SILVER] = 5
	watch_signals(stats)

	# act
	stats.decrease_key(Key.SILVER)

	# assert
	assert_eq(stats.get_key(Key.SILVER), 4, "Should decrease silver key by one")
	assert_signal_emitted(stats, "key_changed")


func test_decrease_key_gold() -> void:

	# arrange
	stats._keys[Key.GOLD] = 5
	watch_signals(stats)

	# act
	stats.decrease_key(Key.GOLD)

	# assert
	assert_eq(stats.get_key(Key.GOLD), 4, "Should decrease gold key by one")
	assert_signal_emitted(stats, "key_changed")


func test_set_get_experience_points():

	# act & assert
	assert_accessors(stats, "experience_points", 0, 100)


func test_gain_experience_points_without_level_up():

	# arrange
	watch_signals(stats)

	# act
	stats.gain_experience_points(10)

	# assert
	assert_eq(stats.get_experience_points(), 10, "Should increase experience points by 10")
	assert_signal_not_emitted(stats, "level_changed")


func test_set_get_level():

	# act & assert
	assert_accessors(stats, "level", 1, 2)


func test_get_next_level_at_1st_level():
	# act
	var next_level_xp = stats.get_next_level_at(1)

	# assert
	assert_eq(next_level_xp, 100, "Should start 2nd level at 100 xp")


func test_get_next_level_at_2nd_level():
	# act
	var next_level_xp = stats.get_next_level_at(2)

	# assert
	assert_eq(next_level_xp, 300, "Should start 2nd level at 300 xp")


func test_get_next_level_at_3rd_level():
	# act
	var next_level_xp = stats.get_next_level_at(3)

	# assert
	assert_eq(next_level_xp, 600, "Should start 3rd level at 600 xp")


func test_gain_experience_points_with_level_up():
	# arrange
	watch_signals(stats)

	# act
	stats.gain_experience_points(150)

	# assert
	assert_signal_emitted_with_parameters(stats, "level_changed", [2, 150])


func test_level_up_from_1st_level_to_2nd_level():

	# arrange
	watch_signals(stats)
	watch_signals(AudioEvents)

	# act
	stats.level_up(1)

	# assert
	assert_signal_emitted_with_parameters(stats, "level_changed", [2, 0])
	assert_signal_emitted(AudioEvents, "play_stream")
	assert_eq(stats.get_level(), 2, "Should level set level to 2")
	assert_eq(stats.get_max_health(), 9, "Should increase max health by 3")
	assert_eq(stats.get_health(), 9, "Should increase health by 3")
	assert_eq(stats.get_strength(), 0, "Should not increase strength")


func test_level_up_from_2nd_level_to_3rd_level():

	# arrange
	stats.set_level(2)
	stats.set_max_health(15)
	stats.set_health(7)
	watch_signals(stats)
	watch_signals(AudioEvents)

	# act
	stats.level_up(2)

	# assert
	assert_signal_emitted_with_parameters(stats, "level_changed", [3, 0])
	assert_signal_emitted(AudioEvents, "play_stream")
	assert_eq(stats.get_level(), 3, "Should level set level to 3")
	assert_eq(stats.get_max_health(), 18, "Should increase max health by 3")
	assert_eq(stats.get_health(), 10, "Should increase health by 3")
	assert_eq(stats.get_strength(), 1, "Should increase strength by 1")


func test_set_experience_points():

	# arrange
	watch_signals(stats)

	# act
	stats.set_experience_points(20)

	# assert
	assert_signal_emitted_with_parameters(stats, "experience_points_changed", [20])


func test_set_level():

	# arrange
	watch_signals(stats)

	# act
	stats.set_level(2)

	# assert
	assert_signal_emitted_with_parameters(stats, "level_changed", [2, 0])


func test_save():

	# arrange
	stats.set_health(1)
	stats.set_max_health(2)
	stats.set_strength(3)
	stats.set_experience_points(4)
	stats.set_level(5)
	stats.set_key(Key.GOLD, 1)
	stats.set_key(Key.SILVER, 2)

	# act
	var save_data = stats.save()

	# assert
	assert_eq(save_data["health"], 1, "Should store health in save_data")
	assert_eq(save_data["max_health"], 2, "Should store max_health in save_data")
	assert_eq(save_data["strength"], 3, "Should store strength in save_data")
	assert_eq(save_data["experience_points"], 4, "Should store experience_points in save_data")
	assert_eq(save_data["level"], 5, "Should store level in save_data")
	assert_eq(save_data["keys"], [1, 2, 0, 0, 0, 0], "Should store keys in save_data")
	assert_eq(save_data["weapon"], "res://Items/Weapons/Dagger.tres", "Should store weapon in save_data")
	assert_eq(save_data["armor"], "res://Items/Armor/Cloth.tres", "Should store armor in save_data")


func test_load():
	
	# arrange
	var player_stats = {
		"health": 1,
		"max_health": 2,
		"strength": 3,
		"experience_points": 4,
		"level": 5,
		"keys": [1, 2, 0, 0, 0, 0],
		"weapon": "res://Items/Weapons/Dagger.tres",
		"armor": "res://Items/Armor/Cloth.tres"
	}
	
	# act
	stats.load(player_stats)
	
	# assert
	assert_eq(stats.get_health(), 1, "Should set health to 1")
	assert_eq(stats.get_max_health(), 2, "Should set max_health to 2")
	assert_eq(stats.get_strength(), 3, "Should set strength to 3")
	assert_eq(stats.get_experience_points(), 4, "Should set experience_points to 4")
	assert_eq(stats.get_level(), 5, "Should set level to 5")
	assert_eq(stats.get_key(Key.SILVER), 2, "Should set keys")
	assert_eq(stats.get_weapon(), PlayerStats.DEFAULT_WEAPON, "Should set weapon")
	assert_eq(stats.get_armor(), PlayerStats.DEFAULT_ARMOR, "Should set armor")
