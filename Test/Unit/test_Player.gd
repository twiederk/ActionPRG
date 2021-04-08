extends 'res://addons/gut/test.gd'

var Player = load("res://Player/Player.gd");
var _player = null;

func before_each():
	_player = Player.new();
	
func after_each():
	_player.free();


func test_take_damage():
	_player.hp = 100;
	var result = _player.take_damage(10);
	
	assert_eq(_player.hp, 90, "HP should be 90");
	
func test_take_damage_not_below_zero():
	_player.hp = 5;
	_player.take_damage(10);
	assert_eq(_player.hp, 0, "HP should be 0");
	
func test_take_damage_with_shield():
	_player.hp = 100;
	_player.is_wearing_sheild = true;
	_player.take_damage(10);
	assert_true(_player.hp > 90, "HP should be greater than 90");
	

