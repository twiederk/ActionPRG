class_name KeyCopper
extends Area2D

signal picked_up_key_copper

func _on_KeyCopper_body_entered(_body: KinematicBody2D) -> void:
	emit_signal("picked_up_key_copper")
	queue_free()
