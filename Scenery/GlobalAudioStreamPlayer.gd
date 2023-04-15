class_name GlobalAudioStreamPlayer
extends AudioStreamPlayer

func _ready():
	#warning-ignore-all:RETURN_VALUE_DISCARDED
	AudioEvents.play_sound.connect(_on_AudioEvents_play_sound)
	AudioEvents.connect("play_stream",Callable(self,"_on_AudioEvents_play_stream"))


func _on_AudioEvents_play_sound(sound: String) -> void:
	var stream_resource = load(str("res://Assets/Sounds/", sound))
	self.stream = stream_resource
	play()


func _on_AudioEvents_play_stream(stream_resource: Resource) -> void:
	self.stream = stream_resource
	play()
