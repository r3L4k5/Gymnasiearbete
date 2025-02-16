extends Camera2D


@export var shake_duration: float = 2
@export var shake_strength: int = 20

var rng = RandomNumberGenerator.new()


func _process(delta):
	shake()


func shake():
	var shake_y = rng.randf_range(-shake_strength, shake_strength)
	var shake_x = rng.randf_range(-shake_strength, shake_strength)
	
	self.offset = lerp(Vector2(shake_x, shake_y), Vector2(0,0), 1)
