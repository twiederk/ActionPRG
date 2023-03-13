class_name Effect
extends AnimatedSprite2D


func _ready():
	# warning-ignore:return_value_discarded
	connect("animation_finished",Callable(self,"_on_animation_finished"))
	play("Animate")

func _on_animation_finished():
	queue_free()
