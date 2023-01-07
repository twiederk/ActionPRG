class_name Potion
extends Area2D

export(Resource) var potion_resource

onready var sprite = $Sprite


func _ready():
	sprite.frame_coords = potion_resource.frame_coords


func _on_Item_body_entered(_body):
	queue_free()
