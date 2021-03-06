class_name Player
extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

const ACCELERATION = 500
const MAX_SPEED = 80
const ROLL_SPEED = 125
const FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox =$HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	OS.set_window_maximized(true)


func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		ROLL:
			roll_state()
			
		ATTACK:
			attack_state()
	
	handle_input()




func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = roll_vector
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
	velocity = move_and_slide(velocity)


func handle_input() -> void:
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
	if Input.is_action_just_pressed("heal"):
		heal()


func roll_animation_finished():
	state = MOVE


func attack_animation_finished():
	state = MOVE


##############
# game logic #
##############
func pickup_key_gold() -> void:
	stats.key_gold = true


func heal() -> void:
	stats.health += 1


func total_heal() -> void:
	stats.health = stats.max_health


###########
# signals #
###########
func _on_Hurtbox_area_entered(area) -> void:
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)


func _on_Hurtbox_invincibility_started() -> void:
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended() -> void:
	blinkAnimationPlayer.play("Stop")


func _on_KeyGold_picked_up_key_gold() -> void:
	pickup_key_gold();


func _on_HealingWell_entered_healing_area() -> void:
	total_heal()


func _on_Sword_picked_up_sword() -> void:
	swordHitbox.damage = 2


