class_name Item
extends Area2D

signal picked_up_item(item_resource)

export(Resource) var item_resource

var _pickable = true

onready var sprite = $Sprite
onready var shadowSprite = $ShadowSprite


func _ready():
	sprite.frame_coords = item_resource.frame_coords
	shadowSprite.visible = item_resource.shadow


func _on_Item_body_entered(body) -> void:
	if is_pickable():
		#warning-ignore:RETURN_VALUE_DISCARDED
		connect("picked_up_item", body, "_on_Item_picked_up_item", [], CONNECT_ONESHOT)
		emit_signal("picked_up_item", item_resource)
		AudioEvents.emit_signal("play_stream", item_resource.pickup_stream)
		LevelStats.emit_signal("node_visited", get_path())
		queue_free()


func set_pickable(pickable: bool) -> void:
	_pickable = pickable


func is_pickable() -> bool:
	return _pickable
