extends 'res://addons/gut/test.gd'

var player : Player = null;


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
	assert_eq(player.stats.health, player.stats.max_health, "Should set health to max when player is totally healed");


func test_heal():
	# arrange
	player.stats.health = 0;
	
	# act
	player.heal();
	
	# assert
	assert_eq(player.stats.health, 1, "Should increase health by 1 when player is healed");
		
	
func test_pickup_sword():
	# arrange
	var iron_sword : WeaponResource = load("res://Resources/Weapons/IronSword.tres")
	
	# act
	player.pickup_sword(iron_sword)

	# assert
	assert_eq(player.stats.get_damage(), 2, "Should have damage of sword when sword is picked up")

