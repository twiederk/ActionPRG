class_name Hitbox
extends Area2D

func get_damage() -> int:
	return get_parent().get_damage()
