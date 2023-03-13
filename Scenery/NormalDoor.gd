class_name NormalDoor
extends Area2D

@export var DOOR_OPEN_SFX: Resource
@export var MISSING_KEY_SFX: Resource

signal door_opened(world_position)

@export var key: int = Key.GOLD


func _on_NormalDoor_body_entered(body):
	if _can_open_door(body):
		AudioEvents.play_stream.emit(DOOR_OPEN_SFX)
		PlayerStats.decrease_key(key)
		LevelStats.node_visited.emit(get_path())
		open()
	elif _is_missing_key(body):
		KeyEvents.key_missing.emit(key)
		AudioEvents.play_stream.emit(MISSING_KEY_SFX)


func _can_open_door(body):
	if body is Player and PlayerStats.get_key(key) > 0:
		return true
	return false


func open() -> void:
	door_opened.emit(global_position)
	queue_free()


func _is_missing_key(body: CharacterBody2D) -> bool:
	return body is Player and PlayerStats.get_key(key) <= 0
