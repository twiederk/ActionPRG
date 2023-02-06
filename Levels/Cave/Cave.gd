class_name Cave
extends Node

onready var fence_tile_map = $FenceTileMap

func _on_NormalDoor_door_opened(world_position):
	var door_position = fence_tile_map.world_to_map(world_position)
	fence_tile_map.set_cellv(door_position, -1)
