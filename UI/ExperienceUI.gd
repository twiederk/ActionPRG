class_name ExperienceUI
extends Control

onready var experience_progress_bar = $ExperienceProgressBar
onready var animation_player = $AnimationPlayer


var _level = 1

# warning-ignore-all:RETURN_VALUE_DISCARDED
func _ready():
	_on_PlayerStats_level_changed(PlayerStats.get_level(), PlayerStats.get_experience_points())
	_on_PlayerStats_experience_points_changed(PlayerStats.get_experience_points())
	PlayerStats.connect("level_changed", self, "_on_PlayerStats_level_changed")
	PlayerStats.connect("experience_points_changed", self, "_on_PlayerStats_experience_points_changed")


func _on_PlayerStats_level_changed(level: int, experience_points: int) -> void:
	_level = level
	experience_progress_bar.max_value = _level * 100
	_on_PlayerStats_experience_points_changed(experience_points)
	if level > 1:
		animation_player.play("LevelUp")


func _on_PlayerStats_experience_points_changed(experience_points: int) -> void:
	experience_progress_bar.value = experience_points - PlayerStats.get_next_level_at(_level - 1)
