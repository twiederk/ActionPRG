class_name ArmorResource
extends ItemResource

export(int) var armor_class = 0

func action(stats) -> void:
	stats.set_armor(self)
