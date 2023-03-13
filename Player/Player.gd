class_name Player
extends CharacterBody2D


const ACCELERATION = 500
const MAX_SPEED = 80
const ROLL_SPEED = 125
const FRICTION = 500


enum PlayerState { MOVE, ROLL, ATTACK }

var state = PlayerState.MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var playerHitbox =$HitboxPivot/PlayerHitbox
@onready var hurtbox = $Hurtbox
@onready var blinkAnimationPlayer = $BlinkAnimationPlayer
@onready var sprite = $Sprite2D


func _ready():
	randomize()
	stats.connect("no_health",Callable(self,"queue_free"))
	animationTree.active = true
	playerHitbox.knockback_direction = roll_vector
	sprite.texture = stats.get_weapon_swipe_texture()
	get_window().mode = Window.MODE_MAXIMIZED if (true) else Window.MODE_WINDOWED


func _physics_process(delta):
	match state:
		PlayerState.MOVE:
			move_state(delta)

		PlayerState.ROLL:
			roll_state()

		PlayerState.ATTACK:
			attack_state()

	handle_input()


func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		playerHitbox.knockback_direction = roll_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()


func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()


func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")


func move():
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity


func handle_input() -> void:
	if Input.is_action_just_pressed("roll"):
		state = PlayerState.ROLL

	if Input.is_action_just_pressed("attack"):
		state = PlayerState.ATTACK

	if Input.is_action_just_pressed("heal"):
		stats.heal()


func roll_animation_finished():
	state = PlayerState.MOVE


func attack_animation_finished():
	state = PlayerState.MOVE


###########
# signals #
###########
func _on_Hurtbox_area_entered(area) -> void:
	stats.hurt(area.get_damage())
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	AudioEvents.emit_signal("play_sound", "Hurt.wav")


func _on_Hurtbox_invincibility_started() -> void:
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended() -> void:
	blinkAnimationPlayer.play("Stop")


func _on_HealingWell_entered_healing_area() -> void:
	stats.total_heal()


func _on_Item_picked_up_item(item_resource: Resource) -> void:
	if (item_resource is WeaponResource):
		sprite.texture = item_resource.swipe_texture
	item_resource.action(stats)


func set_starting_position(starting_position: Vector2) -> void:
	global_position = starting_position


func save() -> Dictionary:
	return {
		"player_position_x": position.x,
		"player_position_y": position.y
	}
