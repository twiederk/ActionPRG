extends GutTest

var projectile: Projectile = null

func before_each():
	projectile = Projectile.new()


func after_each():
	projectile.free()


func test_projectile_can_instanciate():

	# act
	var my_projectile = Projectile.new()

	# arrange
	assert_not_null(my_projectile)
	
	# tear down
	my_projectile.free()


func test_physics_process():

	# arrange
	projectile.velocity = Vector2(5, 10)

	# act
	projectile._physics_process(0.5)

	# assert
	assert_eq(projectile.position, Vector2(2.5, 5), "Should move to new position")


func test_get_damage():
	
	# arrange
	seed(1)
	var ranged_weapon = RangedWeaponResource.new()
	ranged_weapon.damage_die = Die.Name.D4
	projectile.ranged_weapon = ranged_weapon
	
	# act
	var damage = projectile.get_damage()
	
	# assert
	assert_eq(damage, 2, "Should return the damage when hit")
