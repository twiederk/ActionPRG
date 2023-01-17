extends 'res://addons/gut/test.gd'


func test_get_damage():

	# arrange
	seed(1)
	var enemie_resource = EnemieResource.new()
	enemie_resource.damage_die = Die.Name.D8
	var enemie = Bat.new()
	enemie.enemie_resource = enemie_resource
	var hitbox = Hitbox.new();
	enemie.add_child(hitbox)

	# act
	var damage = hitbox.get_damage()

	# assert
	assert_eq(damage, 2, "Should inflict damage of enemie")

	# tear down
	enemie.free()

