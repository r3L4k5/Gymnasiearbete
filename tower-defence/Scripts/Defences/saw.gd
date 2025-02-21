extends Defence


@export var rotation_speed: float = 1
@export var damage: int = 25


func _process(delta):
	global_rotation -= rotation_speed * delta

func _on_spikes_body_entered(body):
	if placeable.is_placed:
		body.take_damage(damage)


func upgrade():
	if not super.upgrade():
		return
	
	damage *= upgrade_rate
	rotation_speed *= upgrade_rate
