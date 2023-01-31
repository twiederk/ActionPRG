class_name Crypt
extends Node

onready var cryptSecretPassageTileMap = $CryptSecretPassageTileMap
onready var cryptWallTileMap = $CryptWallTileMap


func _ready():
	cryptSecretPassageTileMap.visible = false


func _on_SecretDoor_door_opened(world_position):
	cryptSecretPassageTileMap.visible = true
	var door_position = cryptWallTileMap.world_to_map(world_position)
	cryptWallTileMap.set_cellv(door_position, -1)
