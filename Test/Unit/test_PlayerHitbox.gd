extends 'res://addons/gut/test.gd'

var playerHitbox : PlayerHitbox = null;

func before_each():
	playerHitbox = PlayerHitbox.new();

func after_each():
	playerHitbox.free();

func test_get_damage():

	# arrange
	PlayerStats.set_weapon(load("res://Items/Weapons/Sword.tres"))
	seed(1)

	# act
	var damage = playerHitbox.get_damage()

	# assert
	assert_eq(damage, 4, "Should resturn damage of weapon which is currently equipped")
