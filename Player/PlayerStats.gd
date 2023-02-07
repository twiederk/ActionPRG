class_name Stats
extends Node

const MAX_HEALTH = 15
const DEFAULT_WEAPON = preload("res://Items/Weapons/Dagger.tres")
const DEFAULT_ARMOR = preload("res://Items/Armor/Cloth.tres")

signal no_health
signal max_health_changed
signal health_changed
signal weapon_changed(weapon_resource)
signal armor_changed(armor_resource)
signal key_changed(key_material, count)

export(Array, int) var _keys = [0, 0, 0, 0, 0, 0]

var _max_health: int = MAX_HEALTH
var _health = _max_health
var _weapon : WeaponResource = DEFAULT_WEAPON
var _armor : ArmorResource = DEFAULT_ARMOR
var _strength: int = 0


func set_max_health(new_max_health) -> void:
	_max_health = new_max_health
	self._health = min(_health, _max_health)
	emit_signal("max_health_changed", _max_health)


func get_max_health() -> int:
	return _max_health


func set_health(new_health: int) -> void:
	_health = max(new_health, 0)
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
	return Die.roll(_weapon.damage_die) + _strength


func increase_key(key_material) -> void:
	change_key(key_material, 1)


func decrease_key(key_material) -> void:
	change_key(key_material, -1)


func change_key(key_material: int, count: int) -> void:
	var key_count = _keys[key_material] + count
	set_key(key_material, key_count)


func set_key(key_material: int, key_count: int) -> void:
	_keys[key_material] = key_count
	emit_signal("key_changed", key_material, key_count)


func heal(life: int = 1) -> void:
	var health = min(get_health() + life, _max_health)
	set_health(health)


func total_heal() -> void:
	set_health(get_max_health())


func hurt(hit_damage: int = 1) -> void:
	var damage = max(hit_damage - _armor.armor_class, 1)
	set_health(get_health() - damage)


func set_strength(strength: int) -> void:
	_strength = strength


func get_strength() -> int:
	return _strength


func increase_strength(value: int = 1) -> void:
	_strength += value


func get_key(key_material: int) -> int:
	return _keys[key_material]


func reset() -> void:
	set_max_health(MAX_HEALTH)
	set_health(MAX_HEALTH)
	set_strength(0)
	for key_material in _keys.size():
		set_key(key_material, 0)

	set_armor(DEFAULT_ARMOR)
	set_weapon(DEFAULT_WEAPON)
