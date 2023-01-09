class_name Stats
extends Node

signal no_health
signal max_health_changed
signal health_changed
signal key_changed(key_material, count)

export(int) var max_health = 1 setget set_max_health
export(int) var key_copper = 0
export(int) var key_gold = 0

var health = max_health setget set_health
var weapon : WeaponResource = preload("res://Resources/Weapons/WoodSword.tres")


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


func increase_key(key_material) -> void:
	change_key(key_material, 1)


func decrease_key(key_material) -> void:
	change_key(key_material, -1)


func change_key(key_material, count: int) -> void:
	var key_count
	match key_material:
		KeyMaterial.COPPER:
			key_copper += count
			key_count = key_copper
		KeyMaterial.GOLD:
			key_gold += count
			key_count = key_gold
	emit_signal("key_changed", key_material, key_count)
