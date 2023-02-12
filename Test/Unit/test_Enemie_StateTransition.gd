extends GutTest

var enemie: Enemie = null

func before_each():
	enemie = Enemie.new()
	var enemie_resource = EnemieResource.new()
	enemie_resource.ranged_weapon = RangedWeaponResource.new()
	enemie.enemie_resource = enemie_resource


func after_each():
	enemie.free()


func test_chase_state_player_null_IDLE():

	# arrange
	enemie.chaseDetectionZone = stub_detection_zone(false)

	# act
	enemie.chase_state(1.0)

	# assert
	assert_eq(enemie.state, Enemie.EnemieState.IDLE, "Should set state to IDLE when no player is in ChaseDetectionZone")

	# tear down
	enemie.chaseDetectionZone.free()


func test_shoot_state_player_null_IDLE():

	# arrange
	enemie.shootDetectionZone = stub_detection_zone(false)
	enemie.chaseDetectionZone = stub_detection_zone(false)

	# act
	enemie.shoot_state(1.0)

	# assert
	assert_eq(enemie.state, Enemie.EnemieState.IDLE, "Should set state to IDLE when no player is in RangedWeaponDetectionZone")

	# tear down
	enemie.shootDetectionZone.free()


func test_shoot_state_player_in_chase_zone_CHASE():

	# arrange
	enemie.shootDetectionZone = stub_detection_zone(true)
	enemie.chaseDetectionZone = stub_detection_zone(true)

	# act
	enemie.shoot_state(1.0)

	# assert
	assert_eq(enemie.state, Enemie.EnemieState.CHASE, "Should set state to CHASE when no player is in RangedWeaponDetectionZone")

	# tear down
	enemie.shootDetectionZone.free()


func test_seek_player_out_of_shoot_zone_and_out_of_chase_zone_IDLE():

	# arrange
	enemie.state = Enemie.EnemieState.IDLE
	enemie.shootDetectionZone = stub_detection_zone(false)
	enemie.chaseDetectionZone = stub_detection_zone(false)

	# act
	enemie.seek_player()

	# assert
	assert_eq(enemie.state, Enemie.EnemieState.IDLE, "Should stay in state IDLE")


func test_seek_player_in_shoot_zone_and_in_chase_zone_CHASE():

	# arrange
	enemie.state = Enemie.EnemieState.IDLE
	enemie.shootDetectionZone = stub_detection_zone(true)
	enemie.chaseDetectionZone = stub_detection_zone(true)

	# act
	enemie.seek_player()

	# assert
	assert_eq(enemie.state, Enemie.EnemieState.CHASE, "Should activate state CHASE")


func test_seek_player_in_shoot_zone_out_of_chase_zone_SHOOT():
	# arrange
	enemie.state = Enemie.EnemieState.IDLE
	enemie.shootDetectionZone = stub_detection_zone(true)
	enemie.chaseDetectionZone = stub_detection_zone(false)

	# act
	enemie.seek_player()

	# assert
	assert_eq(enemie.state, Enemie.EnemieState.SHOOT, "Should activate in state SHOOT")


func test_seek_player_no_ranged_weapon_IDLE():
	# arrange
	enemie.state = Enemie.EnemieState.IDLE
	enemie.enemie_resource.ranged_weapon = null
	enemie.shootDetectionZone = stub_detection_zone(true)
	enemie.chaseDetectionZone = stub_detection_zone(false)

	# act
	enemie.seek_player()

	# assert
	assert_eq(enemie.state, Enemie.EnemieState.IDLE, "Should stay in state IDLE")


func stub_detection_zone(value: bool) -> PlayerDetectionZone:
	var detection_zone = double(PlayerDetectionZone).new()
	stub(detection_zone, "can_see_player").to_return(value)
	return detection_zone
