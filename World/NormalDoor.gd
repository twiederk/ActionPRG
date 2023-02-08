class_name NormalDoor
extends Area2D

export(Resource) var DOOR_OPEN_SFX
export(Resource) var MISSING_KEY_SFX

signal door_opened(world_position)

export var key: int = Key.GOLD


func _on_NormalDoor_body_entered(body):
	if _can_open_door(body):
		AudioEvents.emit_signal("play_stream", DOOR_OPEN_SFX)
		PlayerStats.decrease_key(key)
		LevelStats.visited_node(get_path())
		open()
	elif _is_missing_key(body):
		KeyEvents.emit_signal("key_missing", key)
		AudioEvents.emit_signal("play_stream", MISSING_KEY_SFX)


func _can_open_door(body):
	if body is Player and PlayerStats.get_key(key) > 0:
		return true
	return false


func open() -> void:
	emit_signal("door_opened", global_position)
	queue_free()


func _is_missing_key(body: KinematicBody2D) -> bool:
	return body is Player and PlayerStats.get_key(key) <= 0