class_name WeaponResource
extends ItemResource

export(Die.Name) var damage_die = Die.Name.D1

func action(stats) -> void:
	stats.set_weapon(self)
