class_name Crypt
extends Node

@onready var cryptSecretPassageTileMap = $CryptSecretPassageTileMap
@onready var cryptWallTileMap = $CryptWallTileMap


func _ready():
	cryptSecretPassageTileMap.visible = false


func _on_SecretDoor_door_opened(world_position):
	cryptSecretPassageTileMap.visible = true
	var door_position = cryptWallTileMap.local_to_map(world_position)
	cryptWallTileMap.erase_cell(0, door_position)
