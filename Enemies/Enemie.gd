class_name Enemie
extends CharacterBody2D

enum EnemieState {IDLE, WANDER, CHASE, SHOOT}

const DAMAGE_FORCE = 200
const PROJECTILE_TILE_FACING = Vector2(1, 1)
const Projectile = preload("res://Enemies/Projectile.tscn")
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

@export var enemie_resource: Resource
@export var boss_name: String = ""

var acceleration = 150
var max_speed = 25
var FRICTION = 200
var WANDER_TARGET_RANGE = 4
var health: int = 0
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var weight = 0
var _ranged_weapon_cool_down_time: float = 0

var state = EnemieState.CHASE

@onready var sprite = $Sprite2D
@onready var shadowSprite = $ShadowSprite
@onready var chaseDetectionZone = $ChaseDetectionZone
@onready var shootDetectionZone = $ShootDetectionZone
@onready var hitbox = $Hitbox
@onready var hurtbox = $Hurtbox
@onready var bodyCollision = $BodyCollision
@onready var softCollision = $SoftCollision
@onready var wanderController = $WanderController
@onready var animationPlayer = $AnimationPlayer
@onready var healthBar = $HealthBar
@onready var nameLabel = $NameLabel
@onready var projectilePosition = $ProjectilePosition


func _ready():
	_init_game_properties()
	nameLabel.text = boss_name
	animationPlayer.seek(randf_range(0, 0.5), true)
	state = pick_random_state([EnemieState.IDLE, EnemieState.WANDER])


func _init_game_properties():
	health = enemie_resource.health
	healthBar.max_value = health
	acceleration = enemie_resource.acceleration
	max_speed = enemie_resource.max_speed
	weight = enemie_resource.weight


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	set_velocity(knockback)
	move_and_slide()
	knockback = velocity

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

	set_velocity(velocity)
	move_and_slide()
	velocity = velocity


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
	var projectile = Projectile.instantiate()
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
	wanderController.start_wander_timer(randf_range(1, 3))


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func die():
	LevelStats.emit_signal("node_visited", get_path())
	PlayerStats.emit_signal("enemie_killed", enemie_resource)
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
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
