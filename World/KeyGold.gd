class_name KeyGold
extends Area2D

signal picked_up_key_gold

func _on_KeyGold_body_entered(_body: KinematicBody2D) -> void:
	emit_signal("picked_up_key_gold")
	queue_free()
