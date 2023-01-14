class_name GlobalAudioStreamPlayer
extends AudioStreamPlayer

func _ready():
	#warning-ignore:RETURN_VALUE_DISCARDED
	AudioEvents.connect("play_sound", self, "_on_AudioEvents_play_sound")


func _on_AudioEvents_play_sound(sound: String) -> void:
	var stream = load(str("res://Assets/Sounds/", sound))
	self.stream = stream
	play()
