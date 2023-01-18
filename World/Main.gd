class_name Main
extends Node


func goto_scene():
	call_deferred("_deferred_goto_scene")


func _deferred_goto_scene():
	get_node("./Village").free()
	var Cave = load("res://Cave/Cave.tscn")
	var cave = Cave.instance()
	add_child(cave)


