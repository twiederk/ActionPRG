extends Node2D

onready var animatedSprite = $AnimatedSprite


func _ready():
	animatedSprite.play("Animate")

