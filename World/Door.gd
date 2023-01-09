class_name Door
extends Node2D

onready var collisionShape = $StaticBody2D/CollisionShape2D


func _on_Area2D_body_entered(body : KinematicBody2D) -> void:
	if body is Player and PlayerStats.key_gold > 0:
		PlayerStats.decrease_key(KeyMaterial.GOLD)
		collisionShape.set_deferred("disabled", true)


