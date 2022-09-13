extends 'res://addons/gut/test.gd'

var ironSword : IronSword = null;

func before_each():
	ironSword = IronSword.new();


func after_each():
	ironSword.free();

func test_damage():
	# act
	var damage = ironSword.damage
	
	# assert
	assert_eq(damage, 2, "should do 1 damage")
	
