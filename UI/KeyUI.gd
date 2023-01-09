extends Control

onready var copper_key_label = $GridContainer/CopperKeyLabel
onready var gold_key_label = $GridContainer/GoldKeyLabel


func _ready():
	copper_key_label.text = str(PlayerStats.key_copper)
	gold_key_label.text = str(PlayerStats.key_gold)
	# warning-ignore:return_value_discarded
	PlayerStats.connect("key_changed", self, "_on_PlayerStats_key_changed")


func _on_PlayerStats_key_changed(key_material: int, count: int) -> void:
	match key_material:
		KeyMaterial.COPPER:
			copper_key_label.text = str(count)
		KeyMaterial.GOLD:
			gold_key_label.text = str(count)

