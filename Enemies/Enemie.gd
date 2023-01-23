class_name Enemie
extends KinematicBody2D

enum EnemieState {IDLE, WANDER, CHASE}

const DAMAGE_FORCE = 200
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

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

var state = EnemieState.CHASE

onready var sprite = $Sprite
onready var shadowSprite = $ShadowSprite
onready var playerDetectionZone = $PlayerDetectionZone
onready var hitbox = $Hitbox
onready var hurtbox = $Hurtbox
onready var bodyCollision = $BodyCollision
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer
onready var healthBar = $HealthBar
onready var nameLabel = $NameLabel


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
	healthBar.set_position(Vector2(-healthBar.rect_size.x / 2, enemie_resource.center.y * 2))
	nameLabel.set_position(Vector2(-nameLabel.rect_size.x /2, enemie_resource.center.y * 2.5))
	if not boss_name.empty():
		nameLabel.visible = true
		nameLabel.text = boss_name
		healthBar.visible = true


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
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = EnemieState.IDLE

	if softCollision.is_colliding():
		velocity = softCollision.get_push_vector() * delta * 400

	velocity = move_and_slide(velocity)


func accelerate_towards_point(point, delta):
	var direction = position.direction_to(point)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	sprite.flip_h = velocity.x < 0


func seek_player():
	if playerDetectionZone.can_see_player():
		state = EnemieState.CHASE


func update_wander():
	state = pick_random_state([EnemieState.IDLE, EnemieState.WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func die():
	LevelStats.visited_node(get_path())
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
