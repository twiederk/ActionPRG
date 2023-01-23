class_name Hitbox
extends Area2D

onready var collisionShape2D = $CollisionShape2D

func get_damage() -> int:
	return get_parent().get_damage()


func set_position(position: Vector2) -> void:
	collisionShape2D.position = position


func set_shape(shape: Shape2D) -> void:
	collisionShape2D.shape = shape
