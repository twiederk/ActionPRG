class_name HealingWell
extends Area2D

signal entered_healing_area

func _on_HealingWell_body_entered(body):
	emit_signal("entered_healing_area")
	
