extends StaticBody2D

@onready var placeable = $Placeable

const ROTATION_SPEED: int = 1
const DAMAGE: int = 25

const COST: int = 5

func _ready():
	placeable.spawn_position = self.global_position

func _process(delta):
	global_rotation += ROTATION_SPEED * delta

func _on_spikes_body_entered(body):
	if placeable.is_placed:
		body.take_damage(DAMAGE)
	
