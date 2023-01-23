extends GutTest


func test_healing_potion():
	# assert
	var healing_potion = load("res://Items/Potions/RedPotion.tres")
	PlayerStats.set_health(1)
	
	# act
	healing_potion.action(PlayerStats)
	
	# assert
	assert_eq(PlayerStats.get_health(), 6, "Should increase player health by 5")
	
	
func test_strength_potion():
	# assert
	var healing_potion = load("res://Items/Potions/BluePotion.tres")
	
	# act
	healing_potion.action(PlayerStats)
	
	# assert
	assert_eq(PlayerStats.get_strength(), 1, "Should increase player strength by 1")
	
	# tear down
	PlayerStats.set_strength(0)
