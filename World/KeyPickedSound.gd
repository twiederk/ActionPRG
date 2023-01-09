extends AudioStreamPlayer

func _on_KeyPickedSound_finished():
	queue_free()
