class_name WeaponResource
extends Resource

export(Vector2) var frame_coords: Vector2
export(bool) var shadow = true
export(Resource) var pickup_stream = preload("res://Assets/Sounds/WeaponPickUp.ogg")
export(Die.Name) var damage_die = Die.Name.D1
export(Resource) var swipe_texture = preload("res://Assets/Graphics/Player/Player.png")


func action(stats) -> void:
	stats.set_weapon(self)
