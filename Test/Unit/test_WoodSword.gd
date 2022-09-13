extends 'res://addons/gut/test.gd'

var woodSword : WoodSword = null;

func before_each():
	woodSword = WoodSword.new();


func after_each():
	woodSword.free();

func test_damage():
	# act
	var damage = woodSword.damage
	
	# assert
	assert_eq(damage, 1, "should do 1 damage")
	
