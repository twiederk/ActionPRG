class_name ItemResource
extends Resource

export(Vector2) var frame_coords: Vector2
export(bool) var shadow = true
export(Resource) var pickup_stream = preload("res://Assets/Sounds/ItemPickUp.ogg")


func action(_stats) -> void:
	pass
