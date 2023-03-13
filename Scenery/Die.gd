class_name Die
extends RefCounted

enum Name { D1 = 1, D2 = 2, D4 = 4, D6 = 6, D8 = 8, D10 = 10 }


static func roll(die: int) -> int:
	return randi() % die + 1
