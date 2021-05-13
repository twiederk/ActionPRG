extends 'res://addons/gut/test.gd'

var Player = load("res://Player/Player.gd");
var player = null;


func before_each():
	player = Player.new();


func after_each():
	player.free();


func test_total_heal():
	# arrange
	player.stats.health = 0;
	
	# act
	player.total_heal();
	
	# assert
	assert_eq(player.stats.health, player.stats.max_health, "HP should be stats.max_health");


func test_heal():
	# arrange
	player.stats.health = 0;
	
	# act
	player.heal();
	
	# assert
	assert_eq(player.stats.health, 1, "HP should increase by 1");

func test_pickup_key_gold():
	# act
	player.pickup_key_gold();
	
	# assert
	assert_eq(player.stats.key_gold, true, "stats.key_gold should be true");
