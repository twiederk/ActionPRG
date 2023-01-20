class_name PlayerHitbox
extends Hitbox

var knockback_direction = Vector2.ZERO

func get_damage() -> int:
	return PlayerStats.get_damage()
