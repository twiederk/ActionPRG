extends GutTest

const bat_normal = preload("res://Resources/Enemies/BatPurple.tres")
const bat_giant = preload("res://Resources/Enemies/GiantBat.tres")

var bat: Bat = null

func before_each():
	bat = Bat.new()


func after_each():
	bat.free()


func test_calculate_knockback_with_bat_normal():

	# arrange
	bat.weight = bat_normal.weight
	var playerHitbox = double(PlayerHitbox).new()
	playerHitbox.knockback_direction = Vector2.DOWN

	# act
	var knockback = bat._calculate_knockback(playerHitbox)

	# assert
	assert_eq(knockback, Vector2(0, 120), "Should knockback normal bat by 120")


func test_calculate_knockback_with_bat_giant():

	# arrange
	bat.weight = bat_giant.weight
	var playerHitbox = double(PlayerHitbox).new()
	playerHitbox.knockback_direction = Vector2.DOWN

	# act
	var knockback = bat._calculate_knockback(playerHitbox)

	# assert
	assert_eq(knockback, Vector2(0, 80), "Should knockback giant bat by 80")
