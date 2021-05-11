class_name TreasureChest
extends Area2D

signal picked_up_treasure

func _on_TreasureChest_body_entered(_body):
	emit_signal("picked_up_treasure")
	queue_free()
