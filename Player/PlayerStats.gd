class_name Stats
extends Node

signal no_health
signal max_health_changed
signal health_changed
signal weapon_changed(weapon_resource)
signal armor_changed(armor_resource)
signal key_changed(key_material, count)

export(int) var key_copper = 0
export(int) var key_gold = 0

var _max_health = 6
var _health = _max_health
var _weapon : WeaponResource = preload("res://Resources/Weapons/WoodSword.tres")
var _armor : ArmorResource = preload("res://Resources/Armor/Cloth.tres")


func set_max_health(new_max_health) -> void:
	_max_health = new_max_health
	self._health = min(_health, _max_health)
	emit_signal("max_health_changed", _max_health)


func get_max_health() -> int:
	return _max_health


func set_health(new_health: int) -> void:
	_health = new_health
	emit_signal("health_changed", _health)
	if _health <= 0:
		emit_signal("no_health")


func get_health() -> int:
	return _health


func set_weapon(weapon_resource: WeaponResource) -> void:
	_weapon = weapon_resource
	emit_signal("weapon_changed", _weapon)


func get_weapon() -> WeaponResource:
	return _weapon


func set_armor(armor_resource: ArmorResource) -> void:
	_armor = armor_resource
	emit_signal("armor_changed", _armor)


func get_armor() -> ArmorResource:
	return _armor


func get_damage() -> int:
	return _weapon.damage


func increase_key(key_material) -> void:
	change_key(key_material, 1)


func decrease_key(key_material) -> void:
	change_key(key_material, -1)


func change_key(key_material, count: int) -> void:
	var key_count
	match key_material:
		Key.COPPER:
			key_copper += count
			key_count = key_copper
		Key.GOLD:
			key_gold += count
			key_count = key_gold
	emit_signal("key_changed", key_material, key_count)
