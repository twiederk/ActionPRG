class_name Plant
extends StaticBody2D

@export var plant_resource: Resource = preload("res://Scenery/Plants/Tree.tres")

@onready var sprite = $Sprite2D

func _ready():
	sprite.texture = plant_resource.texture
