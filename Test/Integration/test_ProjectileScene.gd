extends GutTest

const ProjectileScene = preload("res://Enemies/Projectile.tscn")

func test_ready():
	
	# arrange
	var projectile = ProjectileScene.instantiate()
	var ranged_weapon = RangedWeaponResource.new()
	ranged_weapon.frame_coords = Vector2(10, 20)
	projectile.ranged_weapon = ranged_weapon
	projectile.velocity = Vector2.LEFT
	
	# act
	add_child(projectile)
	
	# assert
	assert_eq(projectile.sprite.frame_coords, Vector2i(10, 20), "Should set frame coords of ranged weapon")

	# tear down
	for child in get_children():
		child.free()
