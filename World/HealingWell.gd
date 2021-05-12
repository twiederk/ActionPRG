class_name HealingWell
extends StaticBody2D

signal entered_healing_area

func _on_HealingArea2D_body_entered(body):
	emit_signal("entered_healing_area")
