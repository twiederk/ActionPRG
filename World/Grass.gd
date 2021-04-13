extends Node2D

onready var GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	grassEffect.global_position = global_position


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()

