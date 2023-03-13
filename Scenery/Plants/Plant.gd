class_name Plant
extends StaticBody2D

export(Resource) var plant_resource = preload("res://Scenery/Plants/Tree.tres")

onready var sprite = $Sprite

func _ready():
	sprite.texture = plant_resource.texture
