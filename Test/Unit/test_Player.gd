extends 'res://addons/gut/test.gd'

var Player = load("res://Player/Player.gd");
var _player = null;

func before_each():
	_player = Player.new();
	
	
func after_each():
	_player.free();
	
	
func test_some_method():
	
	
	var result = _player.some_method()
	
	assert_eq(result, "bananas", "The result should have been bananas");

