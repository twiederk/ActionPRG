extends GutTest

const Projectile = preload("res://Enemies/Projectile.tscn")

func test_ready():
	
	# arrange
	var projectile_scene = Projectile.instantiate()
	var ranged_weapon = RangedWeaponResource.new()
	ranged_weapon.frame_coords = Vector2(10, 20)
	projectile_scene.ranged_weapon = ranged_weapon
	projectile_scene.velocity = Vector2.LEFT
	
	# act
	add_child(projectile_scene)
	
	# assert
	assert_eq(projectile_scene.sprite.frame_coords, Vector2(10, 20), "Should set frame coords of ranged weapon")

	# tear down
	for child in get_children():
		child.free()
