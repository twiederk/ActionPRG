extends GutTest

const BAT_PURPLE = preload("res://Enemies/Bat/BatPurple.tres")
const Enemie = preload("res://Enemies/Enemie.tscn")

func test_die():

	# arrange
	var enemie_scene = Enemie.instance()
	watch_signals(PlayerStats)
	enemie_scene.enemie_resource = BAT_PURPLE
	add_child(enemie_scene)

	# act
	enemie_scene.die()

	# assert
	assert_signal_emitted(PlayerStats, "enemie_killed")
	assert_eq(LevelStats.get_visited_nodes().size(), 1, "Should registerd visited node to LevelStats")
	assert_true(get_child(1) is Effect, "Should add EnemieDeathEffect to scene")

	# tear down
	LevelStats.reset()
	for child in get_children():
		child.free()
	




