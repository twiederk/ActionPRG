class_name Cave
extends Node

@onready var fence_layer: TileMapLayer = $FenceLayer


func _on_NormalDoor_door_opened(world_position):
	var door_position = fence_layer.local_to_map(world_position)
	fence_layer.erase_cell(door_position)
