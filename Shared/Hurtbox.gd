class_name Hurtbox
extends Area2D

signal invincibility_started
signal invincibility_ended

var HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false : set = set_invincible

@onready var timer = $Timer
@onready var collisionShape = $CollisionShape2D


func set_invincible(value):
	invincible = value
	if invincible == true:
		invincibility_started.emit()
	else:
		invincibility_ended.emit()


func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)


func create_hit_effect():
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invincibility_started():
	collisionShape.set_deferred("disabled", true)


func _on_Hurtbox_invincibility_ended():
	collisionShape.disabled = false




