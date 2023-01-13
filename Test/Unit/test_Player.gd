extends 'res://addons/gut/test.gd'

var player : Player = null;


func before_each():
	player = Player.new();


func after_each():
	player.free();


func test_total_heal():
	# arrange
	player.stats.set_health(0);

	# act
	player.total_heal();

	# assert
	assert_eq(player.stats.get_health(), player.stats.get_max_health(), "Should set health to max when player is totally healed");


func test_heal():
	# arrange
	player.stats.set_health(0);

	# act
	player.heal();

	# assert
	assert_eq(player.stats.get_health(), 1, "Should increase health by 1 when player is healed");
