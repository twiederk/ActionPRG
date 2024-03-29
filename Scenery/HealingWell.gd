class_name HealingWell
extends Area2D

@onready var animationPlayer = $AnimationPlayer

signal entered_healing_area

func _on_HealingWell_body_entered(body) -> void:
	if body is Player:
		entered_healing_area.emit()
		AudioEvents.play_sound.emit("HealingWellHeal.ogg")
		animationPlayer.play("Start")


func _on_HealingWell_body_exited(_body) -> void:
	animationPlayer.play("Stop")
