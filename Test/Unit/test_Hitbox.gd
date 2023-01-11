extends 'res://addons/gut/test.gd'

var hitbox : Hitbox = null;

func before_each():
	hitbox = Hitbox.new();

func after_each():
	hitbox.free();

func test_get_damage():
	# act
	var damage = hitbox.get_damage()
	
	# assert
	assert_eq(damage, 1, "Should inflict 1 damage when default hitbox")
