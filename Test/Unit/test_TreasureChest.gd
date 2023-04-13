extends GutTest

const ROBE  = preload("res://Items/Armor/Robe.tres")
const TOPAZ = preload("res://Items/Gems/Topaz.tres")
const GOLD_KEY = preload("res://Items/Keys/GoldKey.tres")
const RED_POTION = preload("res://Items/Potions/RedPotion.tres")
const IRON_SWORD  = preload("res://Items/Weapons/Sword.tres")

var treasure_chest: TreasureChest = null

func before_each():
	treasure_chest = TreasureChest.new()


func after_each():
	treasure_chest.free()


func test_can_be_opened_no_key():
	# act
	var result = treasure_chest.can_be_opened(0)

	# assert
	assert_false(result, "Should not be opend without a key")


func test_can_be_opened_already_opened():
	# arrange
	treasure_chest.treasure_state = TreasureChest.TreasureState.OPEN

	# act
	var result = treasure_chest.can_be_opened(1)

	# assert
	assert_false(result, "Should not be opend when already opened")


func test_can_be_opened_with_key_and_closed():

	# act
	var result = treasure_chest.can_be_opened(1)

	# assert
	assert_true(result, "Should open when closed and key is available")


func test_is_missing_key_no_key():

	# act
	var result = treasure_chest.is_missing_key(0)

	# assert
	assert_true(result, "Should missing key when no key is available and is still closed")



func test_is_missing_key_already_open():
	# arrange
	treasure_chest.treasure_state = TreasureChest.TreasureState.OPEN

	# act
	var result = treasure_chest.is_missing_key(1)

	# assert
	assert_false(result, "Should not missing key when already open")


func test_create_treasure():
	# arrange
	treasure_chest.treasure_content = [ROBE, TOPAZ, GOLD_KEY, RED_POTION, IRON_SWORD]

	# act
	var treasuries = treasure_chest.create_treasuries()

	# assert
	assert_eq(treasuries.size(), 5, "Should contain all treasure items")
	assert_true(treasuries[0] is Armor, "Should be Armor scene")
	assert_true(treasuries[0].item_resource is ArmorResource, "Should be ArmorResource")

	assert_true(treasuries[1] is Gem, "Should be Gem scene")
	assert_true(treasuries[1].item_resource is GemResource, "Should be GemResource")

	assert_true(treasuries[2] is Item, "Should be Key scene")
	assert_true(treasuries[2].item_resource is KeyResource, "Should be KeyResource")

	assert_true(treasuries[3] is Potion, "Should be Potion scene")
	assert_true(treasuries[3].item_resource is PotionResource, "Should be PotionResource")

	assert_true(treasuries[4] is Weapon, "Should be Weapon scene")
	assert_true(treasuries[4].item_resource is WeaponResource, "Should be WeaponResource")

	# tear down
	for treasure in treasuries:
		treasure.free()


func test_get_target_position_first_to_right():

	# arrange
	var global_position = Vector2(10, 10)

	# act
	var target_position = treasure_chest.get_target_position(global_position, 0)

	# assert
	assert_eq(target_position, Vector2(30, 10), "Should move first item right")


func test_get_target_position_second_to_down():

	# arrange
	var global_position = Vector2(10, 10)

	# act
	var target_position = treasure_chest.get_target_position(global_position, 1)

	# assert
	assert_eq(target_position, Vector2(10, 30), "Should move second item down")


func test_get_target_position_third_to_left():

	# arrange
	var global_position = Vector2(10, 10)

	# act
	var target_position = treasure_chest.get_target_position(global_position, 2)

	# assert
	assert_eq(target_position, Vector2(-10, 10), "Should move third item left")


func test_get_target_position_fourth_to_up():

	# arrange
	var global_position = Vector2(10, 10)

	# act
	var target_position = treasure_chest.get_target_position(global_position, 3)

	# assert
	assert_eq(target_position, Vector2(10, -10), "Should move fourth item up")


func test_get_target_position_fifth_again_to_right():

	# arrange
	var global_position = Vector2(10, 10)

	# act
	var target_position = treasure_chest.get_target_position(global_position, 4)

	# assert
	assert_eq(target_position, Vector2(30, 10), "Should move fifth item right")
