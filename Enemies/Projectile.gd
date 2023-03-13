class_name Projectile
extends Node2D

var velocity: Vector2 = Vector2.ZERO
var ranged_weapon

@onready var sprite = $Sprite2D


func _ready():
	sprite.frame_coords = ranged_weapon.frame_coords


func _physics_process(delta: float):
	position = position + (velocity * delta)


func _on_Projectile_body_entered(_body):
	queue_free()


func _on_Projectile_area_entered(_area):
	queue_free()


func get_damage() -> int:
	return Die.roll(ranged_weapon.damage_die)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
