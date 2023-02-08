extends GutTest

var inventoryUI = null

func before_each():
	inventoryUI = InventoryUI.new()


func after_each():
	inventoryUI.free()


func test_get_damage_text():

	# arrange
	var weapon_resource = WeaponResource.new()
	weapon_resource.damage_die = Die.Name.D4

	# act
	var damage_text = inventoryUI._get_damage_text(weapon_resource, 2)

	# assert
	assert_eq(damage_text, "D: 6", "Should display damage of 6")
