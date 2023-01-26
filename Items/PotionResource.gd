class_name PotionResource
extends ItemResource

enum Effect { HEAL, STRENGTH }

export(int) var value = 0
export(Effect) var effect = Effect.HEAL


func action(stats) -> void:
	match effect:
		Effect.HEAL:
			stats.heal(value)
		Effect.STRENGTH:
			stats.increase_strength(value)

