extends GutTest

const bat_purple = preload("res://Enemies/Bat/BatPurple.tres")
const bat_giant = preload("res://Enemies/Bat/GiantBat.tres")

var enemie: Enemie = null

func before_each():
	enemie = Enemie.new()


func after_each():
	enemie.free()


func test_calculate_knockback_with_bat_purple():

	# arrange
	enemie.weight = bat_purple.weight
	var playerHitbox = double(PlayerHitbox).new()
	playerHitbox.knockback_direction = Vector2.DOWN

	# act
	var knockback = enemie._calculate_knockback(playerHitbox)

	# assert
	assert_eq(knockback, Vector2(0, 120), "Should knockback normal bat by 120")


func test_calculate_knockback_with_bat_giant():

	# arrange
	enemie.weight = bat_giant.weight
	var playerHitbox = double(PlayerHitbox).new()
	playerHitbox.knockback_direction = Vector2.DOWN

	# act
	var knockback = enemie._calculate_knockback(playerHitbox)

	# assert
	assert_eq(knockback, Vector2(0, 80), "Should knockback giant bat by 80")


func test_calulate_health_bar_position_bat():

	# arrange
	var health_bar_size = Vector2(18, 3)
	var enemie_center = Vector2(0, -12)

	# act
	var position = enemie._calulate_health_bar_position(health_bar_size, enemie_center)

	# assert
	assert_eq(position, Vector2(-9, -27), "Should place health bar on top of enemie")


func test_calulate_name_label_position_bat():

	# arrange
	var name_label_size = Vector2(100, 11)
	var enemie_center = Vector2(0, -12)

	# act
	var position = enemie._calulate_name_label_position(name_label_size, enemie_center)

	# assert
	assert_eq(position, Vector2(-50, -36), "Should place name label on top of enemie")
