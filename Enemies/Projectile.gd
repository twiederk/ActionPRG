class_name Projectile
extends Node2D

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var damage_die: int

func _physics_process(delta: float):
	position = position + (velocity * delta)


func _on_Projectile_body_entered(_body):
	queue_free()


func _on_Projectile_area_entered(_area):
	queue_free()


func get_damage() -> int:
	return Die.roll(damage_die)


