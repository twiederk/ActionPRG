class_name HealthUI
extends Control


# warning-ignore-all:return_value_discarded
func _ready():
	_on_PlayerStats_health_changed(PlayerStats.get_health())
	_on_PlayerStats_max_health_changed(PlayerStats.get_max_health())
	PlayerStats.connect("health_changed",Callable(self,"_on_PlayerStats_health_changed"))
	PlayerStats.connect("max_health_changed",Callable(self,"_on_PlayerStats_max_health_changed"))


func _on_PlayerStats_health_changed(health):
	for child in get_children():
		child.calculate_health(health)


func _on_PlayerStats_max_health_changed(max_health):
	for child in get_children():
		child.calculate_max_health(max_health)


