extends Area2D

var damage: int

func _ready():
	damage = get_parent().damage

func _on_body_entered(body):
	
	if get_parent().placeable.is_placed:
		
		body.take_damage(damage)
		$Explosion.explode()
