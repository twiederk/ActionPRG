class_name WeaponResource
extends ItemResource

export var damage: int

func action(stats) -> void:
	stats.set_weapon(self)
