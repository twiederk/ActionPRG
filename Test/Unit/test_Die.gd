extends GutTest

func test_can_create_Die():
	# act
	var die = Die.new()

	# assert
	assert_not_null(die)


func test_roll_D4():

	# arrange
	seed(1)

	# act
	var result = Die.roll(Die.Name.D6)

	# assert
	assert_eq(result, 4, "Should roll a 4")


func test_display_name_D4():

	# act
	var result = Die.Name.D4

	# assert
	assert_eq(result, 4, "Should have int value of 4 for D4")
