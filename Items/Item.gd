class_name Item
extends Area2D

signal picked_up_item(item_resource)

@export var item_resource: Resource = preload("res://Items/Weapons/Hand.tres")

var _collectable = true

@onready var sprite = $Sprite2D
@onready var shadowSprite = $ShadowSprite


func _ready():
	sprite.frame_coords = item_resource.frame_coords
	shadowSprite.visible = item_resource.shadow


func _on_Item_body_entered(body) -> void:
	if is_collectable():
		#warning-ignore:RETURN_VALUE_DISCARDED
		picked_up_item.connect(body._on_Item_picked_up_item)
		picked_up_item.emit(item_resource)
		AudioEvents.play_stream.emit(item_resource.pickup_stream)
		LevelStats.node_visited.emit(get_path())
		queue_free()


func set_collectable(pickable: bool) -> void:
	_collectable = pickable


func is_collectable() -> bool:
	return _collectable
