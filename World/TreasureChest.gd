class_name TreasureChest
extends Area2D

const Weapon = preload("res://World/Weapon.tscn")

onready var sprite = $Sprite

enum TreasureState {CLOSE, OPEN}

var treasure_state = TreasureState.CLOSE


func _on_TreasureChest_body_entered(_body):
	if can_be_opend():
		open_treasure_chest()


func can_be_opend() -> bool:
	return PlayerStats.key_copper > 0 and treasure_state == TreasureState.CLOSE


func open_treasure_chest() -> void:
	PlayerStats.decrease_key(KeyMaterial.COPPER)
	treasure_state = TreasureState.OPEN
	sprite.texture = load("res://Assets/Graphics/World/TreasureChest_open.png")
	create_sword_as_treasure()


func create_sword_as_treasure() -> void:
	var sword = Weapon.instance()
	get_parent().call_deferred("add_child", sword)
	call_deferred("tween_sword", sword)


func tween_sword(sword: Weapon) -> void:
	sword.global_position = global_position
	sword.set_pickable(false)
	var target_position = sword.global_position + Vector2(20, 0)
	var tween = create_tween()
	tween.tween_property(sword, "global_position", target_position, 0.4)
	tween.tween_callback(sword, "set_pickable", [true]).set_delay(0.4)

