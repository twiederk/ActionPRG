class_name ArmorResource
extends Resource

export var frame_coords: Vector2
export var shadow = true
export var pickup_stream = preload("res://Assets/Sounds/ArmorPickUp.ogg")
export(int) var armor_class = 0

func action(stats) -> void:
	if armor_class > stats.get_armor().armor_class:
		stats.set_armor(self)
