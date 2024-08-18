class_name Village
extends Node

const STARTING_POSITION = Vector2(495, 152)
const NAME = "Village"

@onready var wall_layer: TileMapLayer = $WallLayer


func _on_NormalDoor_door_opened(world_position):
	var door_position = wall_layer.local_to_map(world_position)
	wall_layer.erase_cell(door_position)
