class_name Overview
extends Node2D

var start_position: Vector2

@onready var village_tile_map: Node2D = $VillageTileMap
@onready var player_sprite: Sprite2D = $PlayerSprite


func _ready() -> void:
	start_position = position


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("overview"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			show_overview()
		else:
			hide_overview()
		get_viewport().set_input_as_handled()


func show_overview():
	var viewport_size = get_viewport().size / 8
	var center_position = Vector2(viewport_size / 2)
	var player_position = get_tree().get_nodes_in_group("player")[0].position
	var offset = (Vector2(320, 48) / 8)
	position = player_position + offset - center_position
	
	player_sprite.position = player_position
	show()


func hide_overview():
	position = start_position
	hide()

	
	
