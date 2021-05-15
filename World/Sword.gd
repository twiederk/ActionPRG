class_name Sword
extends Area2D

signal picked_up_sword

func _on_Sword_body_entered(_body) -> void:
	emit_signal("picked_up_sword")
	queue_free()

