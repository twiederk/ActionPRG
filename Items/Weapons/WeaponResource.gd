class_name WeaponResource
extends Resource

export var frame_coords: Vector2
export var shadow = true
export var pickup_stream = preload("res://Assets/Sounds/WeaponPickUp.ogg")
export(Die.Name) var damage_die = Die.Name.D1

func action(stats) -> void:
	stats.set_weapon(self)
