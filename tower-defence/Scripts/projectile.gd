extends Area2D

var spawn_rotation: float
var spawn_position: Vector2

var damage: int 
var speed: int


func _ready():
	self.global_position = spawn_position

func _physics_process(delta):
	self.global_position += Vector2.RIGHT.rotated(spawn_rotation) * speed * delta 	

func _on_body_entered(body):
	body.take_damage(damage)
	destroy()

func _on_despawn_timer_timeout():
	destroy()

func destroy():
	$Explosion.explode()
	self.queue_free()
