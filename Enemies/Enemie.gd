class_name Enemie
extends KinematicBody2D

enum EnemieState {IDLE, WANDER, CHASE, SHOOT}

const DAMAGE_FORCE = 200
const HEALTH_BAR_MARGIN = 3
const NAME_LABE_MARGIN = 6
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const Projectile = preload("res://Enemies/Projectile.tscn")
const PROJECTILE_TILE_FACING = Vector2(1, 1)

export(int) var acceleration = 150
export(int) var max_speed = 25
export(int) var FRICTION = 200
export(int) var WANDER_TARGET_RANGE = 4
export(int) var health: int = 0
export(Resource) var enemie_resource
export(String) var boss_name = ""


var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var weight = 0
var _ranged_weapon_cool_down_time: float = 0

var state = EnemieState.CHASE

onready var sprite = $Sprite
onready var shadowSprite = $ShadowSprite
onready var chaseDetectionZone = $ChaseDetectionZone
onready var shootDetectionZone = $ShootDetectionZone
onready var hitbox = $Hitbox
onready var hurtbox = $Hurtbox
onready var bodyCollision = $BodyCollision
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer
onready var healthBar = $HealthBar
onready var nameLabel = $NameLabel
onready var projectilePosition = $ProjectilePosition


func _ready():
	_init_game_properties()
	_init_apperance()
	_init_health_bar_and_name_label()
	state = pick_random_state([EnemieState.IDLE, EnemieState.WANDER])


func _init_game_properties():
	health = enemie_resource.health
	healthBar.max_value = health
	acceleration = enemie_resource.acceleration
	max_speed = enemie_resource.max_speed
	weight = enemie_resource.weight


func _init_apperance():
	sprite.position = enemie_resource.center
	sprite.texture = enemie_resource.texture
	shadowSprite.texture = enemie_resource.shadow
	bodyCollision.shape = enemie_resource.body_shape
	hitbox.set_position(enemie_resource.center)
	hitbox.set_shape(enemie_resource.hitbox_shape)
	hurtbox.set_position(enemie_resource.center)
	hurtbox.set_shape(enemie_resource.hurtbox_shape)
	softCollision.set_shape(enemie_resource.soft_shape)
	scale = enemie_resource.scale
	animationPlayer.seek(rand_range(0, 0.5), true)


func _init_health_bar_and_name_label():
	healthBar.set_position(_calulate_health_bar_position(healthBar.rect_size, enemie_resource.center))
	nameLabel.set_position(_calulate_name_label_position(nameLabel.rect_size, enemie_resource.center))
	if not boss_name.empty():
		nameLabel.visible = true
		nameLabel.text = boss_name
		healthBar.visible = true


func _calulate_health_bar_position(rect_size: Vector2, center: Vector2) -> Vector2:
	return Vector2(-rect_size.x / 2.0, center.y * 2 - HEALTH_BAR_MARGIN)


func _calulate_name_label_position(rect_size: Vector2, center: Vector2) -> Vector2:
	return Vector2(-rect_size.x / 2.0, center.y * 2.5 - NAME_LABE_MARGIN)


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)

	match state:
		EnemieState.IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()

		EnemieState.WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()

		EnemieState.CHASE:
			chase_state(delta)

		EnemieState.SHOOT:
			shoot_state(delta)

	if softCollision.is_colliding():
		velocity = softCollision.get_push_vector() * delta * 400

	velocity = move_and_slide(velocity)


func chase_state(delta: float) -> void:
	if chaseDetectionZone.can_see_player():
		var player = chaseDetectionZone.player
		accelerate_towards_point(player.global_position, delta)
	else:
		state = EnemieState.IDLE


func shoot_state(delta: float) -> void:
	if (chaseDetectionZone.can_see_player()):
		state = EnemieState.CHASE
	elif (shootDetectionZone.can_see_player()):
		var player = shootDetectionZone.player
		shoot(delta, player.position)
	else:
		state = EnemieState.IDLE


func accelerate_towards_point(point, delta):
	var direction = position.direction_to(point)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	sprite.flip_h = velocity.x < 0


func shoot(delta: float, player_position: Vector2) -> void:
	sprite.flip_h = player_position.x < global_position.x
	if enemie_resource.ranged_weapon != null:
		_ranged_weapon_cool_down_time -= delta
		if _ranged_weapon_cool_down_time <= 0.0:
			_ranged_weapon_cool_down_time = enemie_resource.ranged_weapon.cool_down_time
			var projectile = create_projectile(player_position, enemie_resource.ranged_weapon)
			get_parent().add_child(projectile)


func create_projectile(player_position: Vector2, ranged_weapon: RangedWeaponResource) -> Projectile:
	var projectile = Projectile.instance()
	projectile.position = calc_projectile_position(player_position)
	var direction = projectile.position.direction_to(player_position)
	projectile.velocity = direction * ranged_weapon.speed
	projectile.ranged_weapon = ranged_weapon
	return projectile


func calc_projectile_position(player_position: Vector2) -> Vector2:
	var projectile_position : Vector2
	if player_position.x >= global_position.x:
		projectile_position = global_position + projectilePosition.position
	else:
		projectile_position = Vector2(global_position.x - projectilePosition.position.x,
									  global_position.y + projectilePosition.position.y)
	return projectile_position


func seek_player():
	if chaseDetectionZone.can_see_player():
		state = EnemieState.CHASE
	elif shootDetectionZone.can_see_player() and has_ranged_weapon():
		state = EnemieState.SHOOT


func has_ranged_weapon() -> bool:
	return enemie_resource.ranged_weapon != null


func update_wander():
	state = pick_random_state([EnemieState.IDLE, EnemieState.WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func die():
	LevelStats.emit_signal("node_visited", get_path())
	PlayerStats.emit_signal("enemie_killed", enemie_resource)
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func get_damage() -> int:
	return Die.roll(enemie_resource.damage_die)


func _on_Hurtbox_area_entered(area: Area2D):
	health -= area.get_damage()
	healthBar.value = health
	knockback = _calculate_knockback(area)
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)
	if health <= 0:
		die()


func _calculate_knockback(area: Area2D) -> Vector2:
	return area.knockback_direction * (DAMAGE_FORCE - weight)


func _on_Hurtbox_invincibility_started():
	animationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	animationPlayer.play("Stop")
	animationPlayer.play("Fly")
