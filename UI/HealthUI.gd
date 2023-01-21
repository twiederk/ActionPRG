class_name HealthUI
extends Control


const HEART_WIDTH = 15
const HEARTS_PER_ROW = 10

onready var heartUIFull1 = $HeartUIFull1
onready var heartUIFull2 = $HeartUIFull2
onready var heartUIEmpty1 = $HeartUIEmpty1
onready var heartUIEmpty2 = $HeartUIEmpty2


# warning-ignore-all:return_value_discarded
func _ready():
	_on_PlayerStats_health_changed(PlayerStats.get_health())
	_on_PlayerStats_max_health_changed(PlayerStats.get_max_health())
	PlayerStats.connect("health_changed", self, "_on_PlayerStats_health_changed")
	PlayerStats.connect("max_health_changed", self, "_on_PlayerStats_max_health_changed")


func _on_PlayerStats_health_changed(health):
	heartUIFull1.rect_size.x = _calculate_width(0, health)
	heartUIFull2.rect_size.x = _calculate_width(1, health)


func _on_PlayerStats_max_health_changed(max_health):
	heartUIEmpty1.rect_size.x = _calculate_width(0, max_health)
	heartUIEmpty2.rect_size.x = _calculate_width(1, max_health)


func _calculate_width(row:int, health: int) -> int:
	var health_of_row = health - (row * HEARTS_PER_ROW)
	if health_of_row < 0:
		health_of_row = 0
	elif health_of_row > HEARTS_PER_ROW:
		health_of_row = HEARTS_PER_ROW
	return health_of_row * HEART_WIDTH


