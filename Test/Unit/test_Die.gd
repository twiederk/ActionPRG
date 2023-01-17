extends GutTest

func test_can_create_Die():
	# act
	var die = Die.new()

	# assert
	assert_not_null(die)


func test_roll_D4():
	
	# arrange
	seed(1)
	var die = Die.new()
	
	# act
	var result = die.roll(Die.Name.D6)
	
	# assert
	assert_eq(result, 4, "Should roll a 4")
	
