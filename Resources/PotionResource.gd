class_name PotionResource
extends ItemResource

enum Effect { HEAL, STRENGTH }

export(Effect) var effect = Effect.HEAL


func action(stats) -> void:
	match effect:
		Effect.HEAL:
			stats.heal()
		Effect.STRENGTH:
			stats.increase_strength()

