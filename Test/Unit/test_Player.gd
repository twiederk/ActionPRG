extends 'res://addons/gut/test.gd'

var Player = load("res://Player/Player.gd");

func test_some_method():
	
	var _player = Player.new()
	var result = _player.some_method()
	pass # Replace with function body.
	
	assert_eq(result, "bananas", "The result should have been bananas");

