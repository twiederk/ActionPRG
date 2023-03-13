class_name ExperienceUI
extends Control

@onready var experience_progress_bar = $ExperienceProgressBar
@onready var level_label = $LevelLabel


var _level = 1

# warning-ignore-all:RETURN_VALUE_DISCARDED
func _ready():
	_on_PlayerStats_level_changed(PlayerStats.get_level(), PlayerStats.get_experience_points())
	_on_PlayerStats_experience_points_changed(PlayerStats.get_experience_points())
	PlayerStats.connect("level_changed",Callable(self,"_on_PlayerStats_level_changed"))
	PlayerStats.connect("experience_points_changed",Callable(self,"_on_PlayerStats_experience_points_changed"))


func _on_PlayerStats_level_changed(level: int, experience_points: int) -> void:
	_level = level
	experience_progress_bar.max_value = _level * 100
	level_label.text = str(level)
	_on_PlayerStats_experience_points_changed(experience_points)


func _on_PlayerStats_experience_points_changed(experience_points: int) -> void:
	experience_progress_bar.value = experience_points - PlayerStats.get_next_level_at(_level - 1)
