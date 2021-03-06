class_name HealingWell
extends Area2D

onready var animationPlayer = $AnimationPlayer

signal entered_healing_area

func _on_HealingWell_body_entered(_body) -> void:
	emit_signal("entered_healing_area")
	animationPlayer.play("Start")


func _on_HealingWell_body_exited(_body) -> void:
	animationPlayer.play("Stop")
