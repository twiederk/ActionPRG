class_name Sword
extends Area2D

signal picked_up_sword

var pickable = false

onready var animationPlayer = $AnimationPlayer

func _ready():
	var player = get_node("../../Player")
	#warning-ignore:RETURN_VALUE_DISCARDED
	connect("picked_up_sword", player, "_on_Sword_picked_up_sword")
	animationPlayer.play("Appear")


func _on_Sword_body_entered(_body) -> void:
	if (pickable == true):
		emit_signal("picked_up_sword")
		queue_free()


func _on_AnimationPlayer_animation_finished(_anim_name):
	pickable = true
