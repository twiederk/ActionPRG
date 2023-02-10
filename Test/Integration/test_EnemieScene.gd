extends GutTest

const Enemie = preload("res://Enemies/Enemie.tscn")

var enemie_scene = null

func before_each():
	var ranged_weapon = RangedWeaponResource.new()
	
	var enemie_resource = EnemieResource.new()
	enemie_resource.ranged_weapon = ranged_weapon
	
	enemie_scene = Enemie.instance()
	enemie_scene.enemie_resource = enemie_resource
	add_child(enemie_scene)


func after_each():
	for child in get_children():
		child.free()


func test_die():

	# arrange
	watch_signals(PlayerStats)
	watch_signals(LevelStats)

	# act
	enemie_scene.die()

	# assert
	assert_signal_emitted(PlayerStats, "enemie_killed")
	assert_signal_emitted(LevelStats, "node_visited")
	assert_true(get_child(1) is Effect, "Should add EnemieDeathEffect to scene")

	# tear down
	LevelStats.reset()


func test_shoot_no_range_attack():

	# arrange
	enemie_scene.enemie_resource.ranged_weapon = null

	# act
	enemie_scene.shoot(0.0, Vector2.ZERO)

	# assert
	assert_eq(get_child_count(), 1, "Should not add projectile to scene, when enemie has no range attack")


func test_shoot_with_range_attack_cooled_down():

	# arrange
	var ranged_weapon = RangedWeaponResource.new()
	ranged_weapon.damage_die = Die.Name.D8
	ranged_weapon.cool_down_time = 1.0
	ranged_weapon.speed = 100
	enemie_scene.enemie_resource.ranged_weapon = ranged_weapon

	# act
	enemie_scene.shoot(0.0, Vector2.ZERO)

	# assert
	assert_true(get_child(1) is Projectile, "Should add projectile to scene, when enemie has range attack and cooled down")
	assert_eq(enemie_scene._ranged_weapon_cool_down_time, 1.0, "Should set cool down time, when enemie shot")

	# tear down
	enemie_scene.enemie_resource.ranged_weapon.damage_die = null
	enemie_scene.enemie_resource.ranged_weapon.cool_down_time = null


func test_shoot_with_range_attack_heated_up():

	# arrange
	enemie_scene.enemie_resource.ranged_weapon.damage_die = Die.Name.D8
	enemie_scene._ranged_weapon_cool_down_time = 1.0

	# act
	enemie_scene.shoot(0.0, Vector2.ZERO)

	# assert
	assert_eq(get_child_count(), 1, "Should not add projectile to scene, when enemie range attack is cooling down")

	# tear down
	enemie_scene.enemie_resource.ranged_weapon.damage_die = null


func test_shoot_with_range_attack_cooling_down():

	# arrange
	enemie_scene.enemie_resource.ranged_weapon.damage_die = Die.Name.D8
	enemie_scene.enemie_resource.ranged_weapon.cool_down_time = 1.0
	enemie_scene._ranged_weapon_cool_down_time = 0.25

	# act
	enemie_scene.shoot(0.5, Vector2.ZERO)

	# assert
	assert_true(get_child(1) is Projectile, "Should add projectile to scene, when enemie has range attack and just cooled down")
	assert_eq(enemie_scene._ranged_weapon_cool_down_time, 1.0, "Should set cool down time, when enemie shot")

	# tear down
	enemie_scene.enemie_resource.ranged_weapon.damage_die = null
	enemie_scene.enemie_resource.ranged_weapon.cool_down_time = null


func test_create_projectile():
	
	# arrange
	var enemie_position = Vector2(10, -50)
	var player_position = Vector2(100, -50)
	var ranged_weapon = RangedWeaponResource.new()
	ranged_weapon.speed = 20
	ranged_weapon.damage_die = Die.Name.D4

	# act
	var projectile = enemie_scene.create_projectile(enemie_position, player_position, ranged_weapon)

	# assert
	assert_eq(projectile.position, enemie_position, "Should place projectile at same position of enemie")
	assert_eq(projectile.direction, Vector2(1, 0), "Should point to position of player")
	assert_eq(projectile.velocity, Vector2(20, 0), "Should move in position of player")
	assert_eq(projectile.damage_die, Die.Name.D4, "Should contain damage die")

	# tear down
	projectile.free()
