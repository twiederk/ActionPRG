class_name Bat
extends KinematicBody2D

enum BatState {IDLE, WANDER, CHASE}

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
var knockback_factor = 0

var state = BatState.CHASE

onready var sprite = $Sprite
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer
onready var healthBar = $HealthBar


onready var name_label = $NameLabel

func _ready():
	acceleration = enemie_resource.acceleration
	max_speed = enemie_resource.max_speed
	health = enemie_resource.health
	healthBar.max_value = health
	sprite.texture = enemie_resource.texture
	scale = enemie_resource.scale
	knockback_factor = enemie_resource.knockback_factor
	if not boss_name.empty():
		name_label.visible = true
		name_label.text = boss_name
		healthBar.visible = true
	animationPlayer.seek(rand_range(0, 0.5), true)
	state = pick_random_state([BatState.IDLE, BatState.WANDER])


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)

	match state:
		BatState.IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()

		BatState.WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()

		BatState.CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = BatState.IDLE

	if softCollision.is_colliding():
		velocity = softCollision.get_push_vector() * delta * 400

	velocity = move_and_slide(velocity)


func accelerate_towards_point(point, delta):
	var direction = position.direction_to(point)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	sprite.flip_h = velocity.x < 0


func seek_player():
	if playerDetectionZone.can_see_player():
		state = BatState.CHASE


func update_wander():
	state = pick_random_state([BatState.IDLE, BatState.WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func die():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func get_damage() -> int:
	return Die.roll(enemie_resource.damage_die)


func _on_Hurtbox_area_entered(area):
	health -= area.get_damage()
	healthBar.value = health
	knockback = area.knockback_vector * knockback_factor
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)
	if health <= 0:
		die()


func _on_Hurtbox_invincibility_started():
	animationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	animationPlayer.play("Stop")
	animationPlayer.play("Fly")
