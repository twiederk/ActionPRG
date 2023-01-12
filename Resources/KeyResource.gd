class_name KeyResource
extends ItemResource

export var material: int


func action(stats) -> void:
	stats.increase_key(material)
