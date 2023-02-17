extends GutTest

const PLAYER_RUBIN_TEXTURE = preload("res://Assets/Graphics/Player/PlayerRubin.png")

var player : Player = null

func before_each():
	player = Player.new()
	player.sprite = Sprite.new()


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
	
	

