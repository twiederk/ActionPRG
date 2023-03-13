class_name InventoryUI
extends Control

@onready var weapon_sprite = $GridContainer/WeaponSprite
@onready var armor_sprite = $GridContainer/ArmorSprite
@onready var damage_label = $DamageLabel
@onready var armor_class_label = $ArmorClassLabel


# warning-ignore-all:RETURN_VALUE_DISCARDED
func _ready():
	_on_PlayerStats_weapon_changed(PlayerStats.get_weapon())
	_on_PlayerStats_armor_changed(PlayerStats.get_armor())
	PlayerStats.connect("weapon_changed",Callable(self,"_on_PlayerStats_weapon_changed"))
	PlayerStats.connect("armor_changed",Callable(self,"_on_PlayerStats_armor_changed"))
	PlayerStats.connect("strength_changed",Callable(self,"_on_PlayerStats_strength_changed"))


func _on_PlayerStats_weapon_changed(weapon_resource: WeaponResource) -> void:
	weapon_sprite.frame_coords = weapon_resource.frame_coords
	damage_label.text = _get_damage_text(weapon_resource, PlayerStats.get_strength())


func _on_PlayerStats_armor_changed(armor_resource: ArmorResource) -> void:
	armor_sprite.frame_coords = armor_resource.frame_coords
	armor_class_label.text = str("AC: ", armor_resource.armor_class)


func _on_PlayerStats_strength_changed(strength: int) -> void:
	damage_label.text = _get_damage_text(PlayerStats.get_weapon(), strength)


func _get_damage_text(weapon_resource: WeaponResource, strength: int) -> String:
	return str("D: ", weapon_resource.damage_die + strength)
