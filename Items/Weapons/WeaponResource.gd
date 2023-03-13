class_name WeaponResource
extends Resource

@export var frame_coords: Vector2
@export var shadow: bool = true
@export var pickup_stream: Resource = preload("res://Assets/Sounds/WeaponPickUp.ogg")
@export var damage_die = Die.Name.D1
@export var swipe_texture: Resource = preload("res://Assets/Graphics/Player/Player.png")


func action(stats) -> void:
	if damage_die > stats.get_weapon().damage_die:
		stats.set_weapon(self)
