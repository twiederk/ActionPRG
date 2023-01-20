class_name EnemieResource
extends Resource

export(int) var health: int = 1
export(Die.Name) var damage_die: int = Die.Name.D1
export(int) var acceleration: int = 150
export(int) var max_speed: int = 25
export(int) var weight: int = 80
export(Texture) var texture: Texture
export(Vector2) var scale = Vector2(1, 1)

