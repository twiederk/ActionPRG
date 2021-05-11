class_name Door
extends Node2D

onready var collisionShape = $StaticBody2D/CollisionShape2D


func _on_Area2D_body_entered(body : KinematicBody2D) -> void:
	if PlayerStats.key_gold == true:
		collisionShape.set_deferred("disabled", true)


