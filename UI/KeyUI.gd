class_name KeyUI
extends Control


@onready var gold_key_label = $GridContainer/GoldKeyLabel
@onready var gold_key_sprite = $GoldKeySprite

@onready var silver_key_label = $GridContainer/SilverKeyLabel
@onready var silver_key_sprite = $SilverKeySprite

@onready var bronze_key_label = $GridContainer/BronzeKeyLabel
@onready var bronze_key_sprite = $BronzeKeySprite


# warning-ignore-all:RETURN_VALUE_DISCARDED
func _ready():
	gold_key_label.text = str(PlayerStats.get_key(Key.GOLD))
	silver_key_label.text = str(PlayerStats.get_key(Key.SILVER))
	bronze_key_label.text = str(PlayerStats.get_key(Key.BRONZE))
	PlayerStats.key_changed.connect(_on_PlayerStats_key_changed)
	KeyEvents.key_missing.connect(_on_KeyEvents_key_missing)


func _on_PlayerStats_key_changed(key_material: int, count: int) -> void:
	var key_label = _get_key_label(key_material)
	key_label.text = str(count)


func _on_KeyEvents_key_missing(key_material: int) -> void:
	var key_sprite = _get_key_sprite(key_material)
	blink_key(key_sprite)


func blink_key(key_sprite) -> void:
	var tween = create_tween()
	for _i in range(10):
		tween.tween_property(key_sprite, "modulate", Color.RED, 0.1)
		tween.tween_property(key_sprite, "modulate", Color.WHITE, 0.1)


func _get_key_label(key_material: int) -> Label:
	var key_label
	match key_material:
		Key.GOLD:
			key_label = gold_key_label
		Key.SILVER:
			key_label = silver_key_label
		Key.BRONZE:
			key_label = bronze_key_label
		_: 
			key_label = gold_key_label
	return key_label


func _get_key_sprite(key_material: int) -> Sprite2D:
	var key_sprite: Sprite2D
	match key_material:
		Key.GOLD:
			key_sprite = gold_key_sprite
		Key.SILVER:
			key_sprite = silver_key_sprite
		Key.BRONZE:
			key_sprite = bronze_key_sprite
		_: 
			key_sprite = gold_key_sprite
	return key_sprite
