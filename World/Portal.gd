class_name PortalArea2D
extends Area2D


func _draw():
	var e = $CollisionShape2D.shape.extents
	draw_rect(Rect2(e.x * -1, e.y * -1, e.x * 2, e.y * 2), Color.brown)


func _on_Portal_body_entered(_body):
	var main = get_node("/root/Main")
	main.goto_scene()
