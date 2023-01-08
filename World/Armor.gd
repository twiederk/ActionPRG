class_name Armor
extends Area2D

export(Resource) var armor_resource

onready var sprite = $Sprite


func _ready():
	sprite.frame_coords = armor_resource.frame_coords


func _on_Item_body_entered(_body):
	queue_free()
