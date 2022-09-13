class_name Stats
extends Node

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health
export(bool) var key_gold = false
export(bool) var key_copper = false

var weapon = WoodSword.new()

signal no_health
signal max_health_changed
signal health_changed

func _ready():
	self.health = max_health


func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)


func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")


func getDamage() -> int:
	return weapon.damage

