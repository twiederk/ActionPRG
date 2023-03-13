class_name RangedWeaponResource
extends Resource


@export var frame_coords: Vector2
@export var shadow = true
@export var pickup_stream = preload("res://Assets/Sounds/WeaponPickUp.ogg")
@export var damage_die = Die.Name.D1 # (Die.Name)
@export var cool_down_time: float = 1.0
@export var speed: int = 100



func action(stats) -> void:
	stats.set_weapon(self)
