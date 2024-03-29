class_name Village
extends Node

const STARTING_POSITION = Vector2(495, 152)
const NAME = "Village"
const WALL_LAYER = 0

@onready var wall_tile_map = $WallTileMap4


func _on_NormalDoor_door_opened(world_position):
	var door_position = wall_tile_map.local_to_map(world_position)
	wall_tile_map.erase_cell(WALL_LAYER, door_position)

