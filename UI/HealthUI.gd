class_name HealthUI
extends Control

const SCALE: float = 2.5

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty


# warning-ignore-all:return_value_discarded
func _ready():
	_on_PlayerStats_health_changed(PlayerStats.get_health())
	_on_PlayerStats_max_health_changed(PlayerStats.get_max_health())
	PlayerStats.connect("health_changed", self, "_on_PlayerStats_health_changed")
	PlayerStats.connect("max_health_changed", self, "_on_PlayerStats_max_health_changed")


func _on_PlayerStats_health_changed(health):
	heartUIFull.rect_size.x = (health / SCALE) * heartUIFull.texture.get_width()


func _on_PlayerStats_max_health_changed(max_health):
	heartUIEmpty.rect_size.x = (max_health / SCALE) * heartUIEmpty.texture.get_width()


