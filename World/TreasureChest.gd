class_name TreasureChest
extends Area2D

enum TreasureState {CLOSE, OPEN}

const Weapon = preload("res://World/Items/Weapon.tscn")

var treasure_state = TreasureState.CLOSE
var check_open_sfx = load("res://Assets/Sounds/ChestOpen.ogg")

onready var sprite = $Sprite
onready var audioStreamPlayer = $AudioStreamPlayer


func _on_TreasureChest_body_entered(_body):
	if can_be_opened(PlayerStats.get_key(Key.COPPER)):
		open_treasure_chest()
	elif is_missing_key(PlayerStats.get_key(Key.COPPER)):
		audioStreamPlayer.play()
		KeyEvents.emit_signal("key_missing", Key.COPPER)


func can_be_opened(key) -> bool:
	return key > 0 and treasure_state == TreasureState.CLOSE


func is_missing_key(key) -> bool:
	return key <= 0 and treasure_state == TreasureState.CLOSE


func open_treasure_chest() -> void:
	PlayerStats.decrease_key(Key.COPPER)
	treasure_state = TreasureState.OPEN
	audioStreamPlayer.stream = check_open_sfx
	audioStreamPlayer.play()
	sprite.texture = load("res://Assets/Graphics/World/TreasureChest_open.png")
	create_sword_as_treasure()


func create_sword_as_treasure() -> void:
	var sword = Weapon.instance()
	sword.item_resource = load("res://Resources/Weapons/IronSword.tres")
	get_parent().call_deferred("add_child", sword)
	call_deferred("tween_sword", sword)


func tween_sword(sword: Weapon) -> void:
	sword.global_position = global_position
	sword.set_pickable(false)
	var target_position = sword.global_position + Vector2(20, 0)
	var tween = create_tween()
	tween.tween_property(sword, "global_position", target_position, 0.4)
	tween.tween_callback(sword, "set_pickable", [true]).set_delay(0.2)

