class_name KeyResource
extends Resource

@export var frame_coords: Vector2
@export var shadow = true
@export var pickup_stream = preload("res://Assets/Sounds/KeyPickUp.ogg")
@export var material: int


func action(stats) -> void:
	stats.increase_key(material)
