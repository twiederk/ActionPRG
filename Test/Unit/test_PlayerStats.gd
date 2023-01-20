extends 'res://addons/gut/test.gd'

var stats : Stats = null;


func before_each():
	stats = Stats.new();


func after_each():
	stats.free();


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
	assert_eq(stats.get_health(), 15, "Should not exceed max health when healed")


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
	stats.increase_key(Key.COPPER)
	stats.set_weapon(null)
	stats.set_armor(null)
	watch_signals(stats)

	# act
	stats.reset()

	# assert
	assert_eq(stats.get_max_health(), Stats.MAX_HEALTH, "Should reset health")
	assert_eq(stats.get_health(), Stats.MAX_HEALTH, "Should reset health")
	assert_eq(stats.get_strength(), 0, "Should reset strength")
	assert_eq(stats.get_key(Key.GOLD), 0, "Should reset keys gold")
	assert_eq(stats.get_key(Key.COPPER), 0, "Should reset keys copper")
	assert_eq(stats.get_weapon(), Stats.DEFAULT_WEAPON, "Should reset weapon")
	assert_eq(stats.get_armor(), Stats.DEFAULT_ARMOR, "Should reset armor")
	
	assert_signal_emitted(stats, "max_health_changed", "Should emit max_health_changed signal")
	assert_signal_emitted(stats, "health_changed", "Should emit health_changed signal")
	assert_signal_emitted(stats, "weapon_changed", "Should emit weapon_changed signal")
	assert_signal_emitted(stats, "armor_changed", "Should emit armor_changed signal")
	assert_signal_emit_count(stats, "key_changed", 2, "Should emit key_changed signal two times")


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


func test_increase_key_copper() -> void:

	# arrange
	stats._keys[Key.COPPER] = 0
	watch_signals(stats)
	
	# act
	stats.increase_key(Key.COPPER)
	
	# assert
	assert_eq(stats.get_key(Key.COPPER), 1, "Should increase copper key by one")
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


func test_decrease_key_copper() -> void:

	# arrange
	stats._keys[Key.COPPER] = 5
	watch_signals(stats)
	
	# act
	stats.decrease_key(Key.COPPER)
	
	# assert
	assert_eq(stats.get_key(Key.COPPER), 4, "Should decrease copper key by one")
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
