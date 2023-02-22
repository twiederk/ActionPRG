class_name EnemieResource
extends Resource

# game properties
export(int) var health: int = 1
export(Die.Name) var damage_die: int = Die.Name.D1
export(int) var acceleration: int = 150
export(int) var max_speed: int = 25
export(int) var weight: int = 80
export(int) var experience_points: int = 0
export(Resource) var ranged_weapon = null
