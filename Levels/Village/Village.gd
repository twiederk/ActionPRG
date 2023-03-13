class_name Village
extends Node

const STARTING_POSITION = Vector2(495, 152)
const NAME = "Village"

@onready var wall_tile_map = $WallTileMap


func _on_NormalDoor_door_opened(world_position):
	var door_position = wall_tile_map.local_to_map(world_position)
	wall_tile_map.set_cellv(door_position, -1)
