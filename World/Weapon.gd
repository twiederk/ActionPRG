class_name Weapon
extends Area2D

signal picked_up_sword

export(Resource) var weapon_resource

var pickable = false

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

func _ready():
	var player = get_node("../../Player")
	
	weapon_resource = load("res://Resources/Weapons/IronSword.tres")
	sprite.frame_coords = weapon_resource.frame_coords
	
	#warning-ignore:RETURN_VALUE_DISCARDED
	connect("picked_up_sword", player, "_on_Sword_picked_up_sword")
	animationPlayer.play("Appear")


func _on_Sword_body_entered(_body) -> void:
	if (pickable == true):
		emit_signal("picked_up_sword", weapon_resource)
		queue_free()


func _on_AnimationPlayer_animation_finished(_anim_name):
	pickable = true
