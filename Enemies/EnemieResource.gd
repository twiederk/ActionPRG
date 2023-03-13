class_name EnemieResource
extends Resource

# game properties
@export var health: int = 1
@export var damage_die: int = Die.Name.D1 # (Die.Name)
@export var acceleration: int = 150
@export var max_speed: int = 25
@export var weight: int = 80
@export var experience_points: int = 0
@export var ranged_weapon: Resource = null
