class_name GiantBat
extends Bat

export(String) var boss_name = ""

onready var name_label = $NameLabel

func _ready():
	name_label.text = boss_name
	
