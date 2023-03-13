class_name Cave
extends Node

@onready var fence_tile_map = $FenceTileMap

func _on_NormalDoor_door_opened(world_position):
	var door_position = fence_tile_map.local_to_map(world_position)
	fence_tile_map.erase_cell(0, door_position)
