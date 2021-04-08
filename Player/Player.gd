extends KinematicBody2D

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector
	else:
		velocity = Vector2.ZERO
		
	move_and_collide(velocity)
	


############### TDD example

var hp = 100;
var max_hp = 100;
var is_wearing_sheild = false;

func take_damage(amount):
	
	if is_wearing_sheild:
		amount /= 2;
		
	hp = max(hp - amount, 0);
	




