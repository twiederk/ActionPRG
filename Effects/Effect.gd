class_name Effect
extends AnimatedSprite


# warning-ignore:return_value_discarded
func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	play("Animate")

func _on_animation_finished():
	queue_free()
