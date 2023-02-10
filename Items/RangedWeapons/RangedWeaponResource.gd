class_name RangedWeaponResource
extends Resource


export var frame_coords: Vector2
export var shadow = true
export var pickup_stream = preload("res://Assets/Sounds/WeaponPickUp.ogg")
export(Die.Name) var damage_die = Die.Name.D1
export(float) var cool_down_time = 1.0
export(int) var speed = 100



func action(stats) -> void:
	stats.set_weapon(self)
