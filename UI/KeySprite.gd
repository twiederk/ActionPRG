class_name KeySprite
extends Sprite2D

@export var key: Resource



func _ready():
	frame_coords = key.frame_coords

