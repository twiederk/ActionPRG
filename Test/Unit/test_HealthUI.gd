extends GutTest

var healthUI = null

func before_each():
	healthUI = HealthUI.new()


func after_each():
	healthUI.free()


func test_calculate_width_5_hearts_in_first_row():

	# act
	var width = healthUI._calculate_width(0, 5)

	# assert
	assert_eq(width, 75, "Should display 5 hearts")


func test_calculate_width_10_hearts_in_first_row():

	# act
	var width = healthUI._calculate_width(0, 15)

	# assert
	assert_eq(width, 150, "Should display 10 hearts")


func test_calculate_width_3_hears_in_second_row():

	# act
	var width = healthUI._calculate_width(1, 13)

	# assert
	assert_eq(width, 45, "Should display 3 hearts")

