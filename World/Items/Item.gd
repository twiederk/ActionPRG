class_name Item
extends Area2D

signal picked_up_item(item_resource)

export(Resource) var item_resource

var _pickable = true

onready var sprite = $Sprite


func _ready() -> void:
	sprite.frame_coords = item_resource.frame_coords
	
	var player = get_node("/root/Main/World/YSort/Player")

	#warning-ignore:RETURN_VALUE_DISCARDED
	connect("picked_up_item", player, "_on_Item_picked_up_item")


func _on_Item_body_entered(_body) -> void:
	if is_pickable():
		emit_signal("picked_up_item", item_resource)
		AudioEvents.emit_signal("play_sound", item_resource.pickup_sfx)
		queue_free()


func set_pickable(pickable: bool) -> void:
	_pickable = pickable


func is_pickable() -> bool:
	return _pickable
