extends GutTest

var heart_row = null

func before_each():
	heart_row = HeartRow.new()


func after_each():
	heart_row.free()


func test_calculate_width_5_hearts_in_first_row():

	# act
	var width = heart_row._calculate_width(5)

	# assert
	assert_eq(width, 75, "Should display 5 hearts")


func test_calculate_width_10_hearts_in_first_row():

	# act
	var width = heart_row._calculate_width(15)

	# assert
	assert_eq(width, 150, "Should display 10 hearts")


func test_calculate_width_3_hears_in_second_row():
	
	# arrange
	heart_row.row = 1

	# act
	var width = heart_row._calculate_width(13)

	# assert
	assert_eq(width, 45, "Should display 3 hearts")

