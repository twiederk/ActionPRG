extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottomRight = $Limits/BottomRight

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRight.position.y
	limit_right = bottomRight.position.x
	_enable_smoothing()


func _enable_smoothing() -> void:
	yield(get_tree().create_timer(0.01), "timeout")
	smoothing_enabled = true
