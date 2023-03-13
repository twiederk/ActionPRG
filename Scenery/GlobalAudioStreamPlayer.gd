class_name GlobalAudioStreamPlayer
extends AudioStreamPlayer

func _ready():
	#warning-ignore-all:RETURN_VALUE_DISCARDED
	AudioEvents.connect("play_sound",Callable(self,"_on_AudioEvents_play_sound"))
	AudioEvents.connect("play_stream",Callable(self,"_on_AudioEvents_play_stream"))


func _on_AudioEvents_play_sound(sound: String) -> void:
	var stream = load(str("res://Assets/Sounds/", sound))
	self.stream = stream
	play()


func _on_AudioEvents_play_stream(stream: Resource) -> void:
	self.stream = stream
	play()
