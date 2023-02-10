class_name EnemieResource
extends Resource

# game properties
export(int) var health: int = 1
export(Die.Name) var damage_die: int = Die.Name.D1
export(int) var acceleration: int = 150
export(int) var max_speed: int = 25
export(int) var weight: int = 80
export(int) var experience_points: int = 0
export(Resource) var ranged_weapon = null


# appearance
export(Vector2) var center = Vector2(0, -12)
export(Texture) var texture: Texture
export(Texture) var shadow: Texture = preload("res://Assets/Graphics/Shadows/SmallShadow.png")
export(Vector2) var scale = Vector2(1, 1)
export(Shape2D) var body_shape: Shape2D = preload("res://Enemies/Bat/BatBodyCollisionShape.tres")
export(Shape2D) var hitbox_shape: Shape2D = preload("res://Enemies/Bat/BatHitboxCollisionShape.tres")
export(Shape2D) var hurtbox_shape: Shape2D = preload("res://Enemies/Bat/BatHurtboxCollisionShape.tres")
export(Shape2D) var soft_shape: Shape2D = preload("res://Enemies/Bat/BatSoftCollisionShape.tres")

