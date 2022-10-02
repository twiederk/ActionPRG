class_name TreasureChest
extends Area2D

const TreasureChestOpen = preload("res://World/TreasureChestOpen.tscn")
const Sword = preload("res://World/Sword.tscn")

signal picked_up_treasure

func _on_TreasureChest_body_entered(_body):
	if PlayerStats.key_copper == true:
		open_treasure_chest()
		queue_free()
		
func open_treasure_chest() -> void:
	create_open_treasure_chest()
	create_sword_as_treasure()


func create_open_treasure_chest() -> void:
	var treasureChestOpen = TreasureChestOpen.instance()
	get_parent().add_child(treasureChestOpen)
	treasureChestOpen.global_position = global_position


func create_sword_as_treasure() -> void:
	var sword = Sword.instance()
	get_parent().add_child(sword)
	sword.global_position = global_position

