extends 'res://addons/gut/test.gd'

var swordHitbox : SwordHitbox = null;

func before_each():
	swordHitbox = SwordHitbox.new();

func after_each():
	swordHitbox.free();

func test_get_damage():
	
	# arrange
	PlayerStats.weapon = load("res://Resources/Weapons/IronSword.tres")
	
	# act
	var damage = swordHitbox.get_damage()
	
	# assert
	assert_eq(damage, 2, "Should resturn damage of weapon which is currently equipped")
	
