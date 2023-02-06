class_name InventoryUI
extends Control

onready var weapon_sprite = $GridContainer/WeaponSprite
onready var armor_sprite = $GridContainer/ArmorSprite
onready var damage_label = $DamageLabel
onready var armor_class_label = $ArmorClassLabel


# warning-ignore-all:RETURN_VALUE_DISCARDED
func _ready():
	_on_PlayerStats_weapon_changed(PlayerStats.get_weapon())
	_on_PlayerStats_armor_changed(PlayerStats.get_armor())
	PlayerStats.connect("weapon_changed", self, "_on_PlayerStats_weapon_changed")
	PlayerStats.connect("armor_changed", self, "_on_PlayerStats_armor_changed")


func _on_PlayerStats_weapon_changed(weapon_resource: WeaponResource) -> void:
	weapon_sprite.frame_coords = weapon_resource.frame_coords
	damage_label.text = str("D: ", weapon_resource.damage_die)


func _on_PlayerStats_armor_changed(armor_resource: ArmorResource) -> void:
	armor_sprite.frame_coords = armor_resource.frame_coords
	armor_class_label.text = str("AC: ", armor_resource.armor_class)
