class_name Plant
extends StaticBody2D

export(Resource) var plant_resource = preload("res://World/Plants/Tree.tres")

onready var sprite = $Sprite

func _ready():
	sprite.texture = plant_resource.texture
