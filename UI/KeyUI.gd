extends Control

onready var copper_key_label = $GridContainer/CopperKeyLabel
onready var copper_key_texture = $GridContainer/CopperKeyTexture

onready var gold_key_label = $GridContainer/GoldKeyLabel
onready var gold_key_texture = $GridContainer/GoldKeyTexture


# warning-ignore-all:RETURN_VALUE_DISCARDED
func _ready():
	copper_key_label.text = str(PlayerStats.key_copper)
	gold_key_label.text = str(PlayerStats.key_gold)
	PlayerStats.connect("key_changed", self, "_on_PlayerStats_key_changed")
	KeyEvents.connect("key_missing", self, "_on_KeyEvents_key_missing")


func _on_PlayerStats_key_changed(key_material: int, count: int) -> void:
	var key_label = _get_key_label(key_material)
	key_label.text = str(count)


func _on_KeyEvents_key_missing(key_material: int) -> void:
	var key_texture = _get_key_texture(key_material)
	blink_key(key_texture)


func blink_key(key_texture) -> void:
	var tween = create_tween()
	for _i in range(5):
		tween.tween_property(key_texture, "modulate", Color.red, 0.1)
		tween.tween_property(key_texture, "modulate", Color.white, 0.1)


func _get_key_label(key_material: int) -> Label:
	var key_label
	match key_material:
		KeyMaterial.COPPER:
			key_label = copper_key_label
		KeyMaterial.GOLD:
			key_label = gold_key_label
	return key_label


func _get_key_texture(key_material: int) -> TextureRect:
		var key_texture: TextureRect
		match key_material:
			KeyMaterial.COPPER:
				key_texture = copper_key_texture
			KeyMaterial.GOLD:
				key_texture = gold_key_texture
		return key_texture
