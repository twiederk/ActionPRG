class_name TreasureChest
extends Area2D

enum TreasureState {CLOSE, OPEN}

const ArmorScene = preload("res://Items/Armor/Armor.tscn")
const GemScene = preload("res://Items/Gems/Gem.tscn")
const KeyScene = preload("res://Items/Keys/Key.tscn")
const PotionScene = preload("res://Items/Potions/Potion.tscn")
const WeaponScene = preload("res://Items/Weapons/Weapon.tscn")
const TWEEN_DISTANCE = 20

@export var treasure_content: Array[Resource] = []

var treasure_state = TreasureState.CLOSE
var check_open_sfx = load("res://Assets/Sounds/ChestOpen.ogg")
var directions = {
	0: Vector2.RIGHT,
	1: Vector2.DOWN,
	2: Vector2.LEFT,
	3: Vector2.UP,
}

@onready var sprite = $Sprite2D
@onready var audioStreamPlayer = $AudioStreamPlayer


func _on_TreasureChest_body_entered(_body):
	if can_be_opened(PlayerStats.get_key(Key.SILVER)):
		open_treasure_chest()
	elif is_missing_key(PlayerStats.get_key(Key.SILVER)):
		audioStreamPlayer.play()
		KeyEvents.key_missing.emit(Key.SILVER)


func can_be_opened(key) -> bool:
	return key > 0 and treasure_state == TreasureState.CLOSE


func is_missing_key(key) -> bool:
	return key <= 0 and treasure_state == TreasureState.CLOSE


func open_treasure_chest() -> void:
	PlayerStats.decrease_key(Key.SILVER)
	LevelStats.node_visited.emit(get_path())
	treasure_state = TreasureState.OPEN
	audioStreamPlayer.stream = check_open_sfx
	audioStreamPlayer.play()
	sprite.texture = load("res://Assets/Graphics/World/TreasureChest_open.png")
	place_treasuries(create_treasuries())


func create_treasuries() -> Array:
	var treasuries = []
	for item_resouce in treasure_content:
		var node = create_node(item_resouce)
		treasuries.append(node)
	return treasuries


func create_node(item_resource: Resource) -> Node2D:
	var node
	if item_resource is ArmorResource:
		node = ArmorScene.instantiate()
	if item_resource is GemResource:
		node = GemScene.instantiate()
	if item_resource is KeyResource:
		node = KeyScene.instantiate()
	if item_resource is PotionResource:
		node = PotionScene.instantiate()
	if item_resource is WeaponResource:
		node = WeaponScene.instantiate()
	node.item_resource = item_resource
	return node


func get_target_position(global_pos: Vector2, index: int) -> Vector2:
	return global_pos + (directions[index % directions.size()] * TWEEN_DISTANCE)


func place_treasuries(treasuries: Array) -> void:
	var index = 0
	for treasure in treasuries:
		var target_position = get_target_position(global_position, index)
		get_parent().call_deferred("add_child", treasure)
		call_deferred("tween_treasure", treasure, target_position)
		index += 1


func tween_treasure(item: Item, target_position) -> void:
	item.global_position = global_position
	item.set_collectable(false)
	var tween = create_tween()
	tween.tween_property(item, "global_position", target_position, 0.4)
	tween.tween_callback(Callable(item,"set_collectable").bind(true)).set_delay(0.2)
