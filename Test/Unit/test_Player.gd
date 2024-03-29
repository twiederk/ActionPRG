extends GutTest

const PLAYER_RUBIN_TEXTURE = preload("res://Assets/Graphics/Player/PlayerRubin.png")

var player : Player = null

func before_each():
	player = Player.new()
	player.sprite = Sprite2D.new()


func after_each():
	player.sprite.free()
	player.free()


func test_on_Item_picked_up_item():

	# arrange
	var weapon = WeaponResource.new()
	weapon.swipe_texture = PLAYER_RUBIN_TEXTURE

	# act
	player._on_Item_picked_up_item(weapon)

	# assert
	assert_eq(player.sprite.texture, PLAYER_RUBIN_TEXTURE, "Should set PlayerRubin.png as texture")


func test_save():

	# arrange
	player.position = Vector2(10, 20)

	# act
	var save_data = player.save()

	# assert
	assert_eq(save_data["player_position_x"], 10.0, "Should store x-position in save_data")
	assert_eq(save_data["player_position_y"], 20.0, "Should store y-position in save_data")


