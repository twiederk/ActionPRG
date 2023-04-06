class_name Effect
extends AnimatedSprite2D


func _ready():
	animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)
	play("Animate")

func _on_animation_finished():
	queue_free()
