class_name SwordHitbox
extends Hitbox

var knockback_vector = Vector2.ZERO

func get_damage() -> int:
	return PlayerStats.get_damage()
