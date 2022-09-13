extends "res://addons/gut/test.gd"

	
func test_max_health():
	# act
	PlayerStats._ready()
	
	# assert
	assert_eq(PlayerStats.max_health, 6, "Should have max health 6 when game starts")


func test_health():
	# act
	PlayerStats._ready()
	
	# assert
	assert_eq(PlayerStats.health, 6, "Should have health 6 when game starts")
	

func test_getDamage():
	# arrange
	PlayerStats.weapon = WoodSword.new()
	
	# act
	var damage = PlayerStats.getDamage()
	
	# assert
	assert_eq(damage, 1, "Should resturn damage of current weapon")


