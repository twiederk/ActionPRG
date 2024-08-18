class_name Crypt
extends Node

@onready var crypt_secret_passage_layer: TileMapLayer = $CryptSecretPassageLayer
@onready var crypt_wall_layer: TileMapLayer = $CryptWallLayer


func _ready():
	crypt_secret_passage_layer.visible = false


func _on_SecretDoor_door_opened(world_position):
	crypt_secret_passage_layer.visible = true
	var door_position = crypt_wall_layer.local_to_map(world_position)
	crypt_wall_layer.erase_cell(door_position)
