class_name HeartRow
extends Control

const HEART_WIDTH = 15
const HEARTS_PER_ROW = 10

@export var row: int

@onready var heartUIFull = $HeartUIFull
@onready var heartUIEmpty = $HeartUIEmpty

func calculate_health(health: int) -> void:
	heartUIFull.size.x = _calculate_width(health)


func calculate_max_health(max_health: int) -> void:
	heartUIEmpty.size.x = _calculate_width(max_health)


func _calculate_width(health: int) -> int:
	var health_of_row = health - (row * HEARTS_PER_ROW)
	if health_of_row < 0:
		health_of_row = 0
	elif health_of_row > HEARTS_PER_ROW:
		health_of_row = HEARTS_PER_ROW
	return health_of_row * HEART_WIDTH
