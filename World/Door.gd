class_name Door
extends Node2D

var door_open_sfx = load("res://Assets/Sounds/DoorOpen.ogg")

onready var collisionShape = $StaticBody2D/CollisionShape2D
onready var audioStreamPlayer = $AudioStreamPlayer

var _opened: bool = false

func _on_Area2D_body_entered(body : KinematicBody2D) -> void:
	if can_open_door(body, PlayerStats.key_gold):
		_opened = true
		audioStreamPlayer.stream = door_open_sfx
		audioStreamPlayer.play()
		PlayerStats.decrease_key(Key.GOLD)
		collisionShape.set_deferred("disabled", true)
	elif is_missing_key(body, PlayerStats.key_gold):
		audioStreamPlayer.play()
		KeyEvents.emit_signal("key_missing", Key.GOLD)


func can_open_door(body: KinematicBody2D, key: int) -> bool:
	return body is Player and key > 0 and !_opened


func is_missing_key(body: KinematicBody2D, key: int) -> bool:
	return body is Player and key <= 0 and !_opened
