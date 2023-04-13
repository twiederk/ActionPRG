extends GutTest

var experienceUI = null

func before_each():
	experienceUI = ExperienceUI.new()
	experienceUI.experience_progress_bar = ProgressBar.new()
	experienceUI.level_label = Label.new()


func after_each():
	experienceUI.experience_progress_bar.free()
	experienceUI.level_label.free()
	experienceUI.free()


func test_on_PlayerStats_level_changed():


	# act
	experienceUI._on_PlayerStats_level_changed(2, 100)

	# assert
	assert_eq(experienceUI._level, 2, "Should set _level to 2")
	assert_eq(experienceUI.experience_progress_bar.value, 0.0, "Should set max value to 0")
	assert_eq(experienceUI.experience_progress_bar.max_value, 200.0, "Should set max value to 200")



func test_on_PlayerStats_experience_points_changed_on_1st_level():

	# act
	experienceUI._on_PlayerStats_experience_points_changed(50)

	# assert
	assert_eq(experienceUI.experience_progress_bar.value, 50.0, "Should set value to 50")
	assert_eq(experienceUI.experience_progress_bar.max_value, 100.0, "Should have max value of 100")


func test_on_PlayerStats_experience_points_changed_on_2nd_level():

	# arrange
	experienceUI.experience_progress_bar.max_value = 200
	experienceUI._level = 2

	# act
	experienceUI._on_PlayerStats_experience_points_changed(250)

	# assert
	assert_eq(experienceUI.experience_progress_bar.value, 150.0, "Should set value to 150")


func test_on_PlayerStats_level_changed_from_1st_level_having_100_xp():
	# arrange
	experienceUI.experience_progress_bar.max_value = 100
	experienceUI._level = 1

	# act
	experienceUI._on_PlayerStats_level_changed(2, 100)

	# assert
	assert_eq(experienceUI.experience_progress_bar.value, 0.0, "Should set value to 0")
	assert_eq(experienceUI.experience_progress_bar.max_value, 200.0, "Should set value to 200")


func test_on_PlayerStats_level_changed_from_1st_level_having_120_xp():
	# arrange
	experienceUI.experience_progress_bar.max_value = 100
	experienceUI._level = 1

	# act
	experienceUI._on_PlayerStats_level_changed(2, 120)

	# assert
	assert_eq(experienceUI.experience_progress_bar.value, 20.0, "Should set value to 20")
	assert_eq(experienceUI.experience_progress_bar.max_value, 200.0, "Should set value to 200")


func test_on_PlayerStats_level_changed_from_2nd_level_having_380_xp():
	# arrange
	experienceUI.experience_progress_bar.max_value = 100
	experienceUI._level = 1

	# act
	experienceUI._on_PlayerStats_level_changed(3, 380)

	# assert
	assert_eq(experienceUI.experience_progress_bar.value, 80.0, "Should set value to 80")
	assert_eq(experienceUI.experience_progress_bar.max_value, 300.0, "Should set value to 300")

