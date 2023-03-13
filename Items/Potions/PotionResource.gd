class_name PotionResource
extends Resource

enum Effect { HEAL, STRENGTH }

@export var frame_coords: Vector2
@export var shadow = true
@export var pickup_stream = preload("res://Assets/Sounds/PotionPickUp.ogg")
@export var value: int = 0
@export var effect: Effect = Effect.HEAL


func action(stats) -> void:
	match effect:
		Effect.HEAL:
			stats.heal(value)
		Effect.STRENGTH:
			stats.increase_strength(value)

