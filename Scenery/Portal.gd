class_name PortalArea2D
extends Area2D

@export var target_level: String = Village.NAME
@export var starting_position: Vector2 = Vector2.ZERO


func _draw():
	var e = $CollisionShape2D.shape.size
	draw_rect(Rect2(e.x * -1, e.y * -1, e.x * 2, e.y * 2), Color(1, 1, 1, 0))


func _on_Portal_body_entered(body):
	if body is Player:
		var main = get_node(Main.MAIN_NODE_PATH)
		main.goto_level(target_level, starting_position)
