class_name Key
extends Area2D

enum { COPPER, GOLD }

signal picked_up_key

export(Resource) var key_resource

const KeyPickedSound = preload("res://World/KeyPickedSound.tscn")

onready var sprite = $Sprite


func _ready():
	sprite.frame_coords = key_resource.frame_coords


func _on_Key_body_entered(_body: KinematicBody2D) -> void:
	var keyPickedSound = KeyPickedSound.instance()
	get_tree().current_scene.add_child(keyPickedSound)
	emit_signal("picked_up_key", key_resource.material)
	queue_free()

