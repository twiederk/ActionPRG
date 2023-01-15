extends 'res://addons/gut/test.gd'

var stats : Stats = null;


func before_each():
	stats = Stats.new();


func after_each():
	stats.free();


func test_total_heal():
	# arrange
	stats.set_health(0);

	# act
	stats.total_heal();

	# assert
	assert_eq(stats.get_health(), stats.get_max_health(), "Should set health to max when stats is totally healed");


func test_heal():
	# arrange
	stats.set_health(0);

	# act
	stats.heal();

	# assert
	assert_eq(stats.get_health(), 1, "Should increase health by 1 when stats is healed");


func test_get_damage():

	# act
	var damage = stats.get_damage()

	# assert
	assert_eq(damage, 1, "Should be damage of Dagger")


func test_get_damage_with_strength_1():

	# arrange
	stats.increase_strength()

	# act
	var damage = stats.get_damage()

	# assert
	assert_eq(damage, 2, "Should be damage of Dagger and strength")


func test_hurt_shirt_armor():

	# arrange
	stats.set_health(10)

	# act
	stats.hurt(3)

	# assert
	assert_eq(stats.get_health(), 7, "Should reduce health by damage")


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
	assert_eq(stats.get_health(), 10, "Should not increase health when armor class is higher than hit damage")
