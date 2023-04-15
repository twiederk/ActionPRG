class_name SecretDoor
extends Area2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

signal door_opened(world_position)


func _on_SecretDoor_area_entered(area):
	if area is PlayerHitbox:
		LevelStats.node_visited.emit(get_path())
		_collapse()
		open()


func open() -> void:
	emit_signal("door_opened", global_position)
	queue_free()


func _collapse():
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
