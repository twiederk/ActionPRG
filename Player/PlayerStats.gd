class_name Stats
extends Node


signal no_health
signal max_health_changed
signal health_changed
signal strength_changed(strength)
signal weapon_changed(weapon_resource)
signal armor_changed(armor_resource)
signal key_changed(key_material, count)
signal level_changed(level, experience_points)
signal experience_points_changed(experience_points)
# warning-ignore:UNUSED_SIGNAL
signal enemie_killed(enemie)


const MAX_HEALTH = 6
const LEVEL_UP_HEALTH = 3
const DEFAULT_WEAPON = preload("res://Items/Weapons/Dagger.tres")
const DEFAULT_ARMOR = preload("res://Items/Armor/Cloth.tres")
const LEVEL_UP_VOICE = preload("res://Assets/Sounds/LevelUpVoice.ogg")

@export var _keys = [0, 0, 0, 0, 0, 0] # (Array, int)

var _max_health: int = MAX_HEALTH
var _health = _max_health
var _weapon : WeaponResource = DEFAULT_WEAPON
var _armor : ArmorResource = DEFAULT_ARMOR
var _strength: int = 0
var _experience_points: int = 0
var _level: int = 1


func _ready():
	# warning-ignore:RETURN_VALUE_DISCARDED
	connect("enemie_killed",Callable(self,"_on_enemie_killed"))


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


func get_weapon_swipe_texture() -> Texture2D:
	return _weapon.swipe_texture


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
	emit_signal("strength_changed", _strength)


func get_strength() -> int:
	return _strength


func increase_strength(value: int = 1) -> void:
	set_strength(get_strength() + value)


func get_key(key_material: int) -> int:
	return _keys[key_material]


func reset() -> void:
	set_max_health(MAX_HEALTH)
	set_health(MAX_HEALTH)
	set_strength(0)
	set_experience_points(0)
	set_level(1)
	for key_material in _keys.size():
		set_key(key_material, 0)

	set_armor(DEFAULT_ARMOR)
	set_weapon(DEFAULT_WEAPON)


func set_experience_points(experience_points: int) -> void:
	_experience_points = experience_points
	emit_signal("experience_points_changed", _experience_points)


func get_experience_points() -> int:
	return _experience_points


func gain_experience_points(experience_points: int) -> void:
	set_experience_points(get_experience_points() + experience_points)
	if get_experience_points() >= get_next_level_at(get_level()):
		level_up(get_level())


func set_level(level: int) -> void:
	_level = level
	emit_signal("level_changed", _level, _experience_points)


func get_level() -> int:
	return _level


func _on_enemie_killed(enemie: EnemieResource) -> void:
	gain_experience_points(enemie.experience_points)


func get_next_level_at(current_level: int) -> int:
	var next_level = 0
	for level in current_level + 1:
		next_level += level * 100
	return next_level


func level_up(current_level: int) -> void:
	AudioEvents.emit_signal("play_stream", LEVEL_UP_VOICE)
	var next_level = current_level + 1
	set_level(next_level)
	set_max_health(get_max_health() + LEVEL_UP_HEALTH)
	set_health(get_health() + LEVEL_UP_HEALTH)
	if next_level % 2 == 1:
		increase_strength()


func save() -> Dictionary:
	return {
		"health": _health,
		"max_health": _max_health,
		"strength": _strength,
		"experience_points": _experience_points,
		"level": _level,
		"keys": _keys,
		"weapon": _weapon.resource_path,
		"armor": _armor.resource_path
	}


func load(player_data: Dictionary) -> void:
	set_health(player_data["health"])
	set_max_health(player_data["max_health"])
	set_strength(player_data["strength"])
	set_experience_points(player_data["experience_points"])
	set_level(player_data["level"])
	var keys = player_data["keys"]
	for index in keys.size():
		set_key(index, keys[index])
	set_weapon(load(player_data["weapon"]))
	set_armor(load(player_data["armor"]))
