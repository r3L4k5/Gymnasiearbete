extends Area2D


@onready var health_bar = $HealthBar
@export var health: int = 200:
	set(value):
		health = clamp(value, 0, 200)
		health_bar.value = health
		
		if health <= 0:
			fortress_destroyed.emit()

signal fortress_destroyed

func _ready():
	health_bar.max_value = health
	health_bar.value = health

func _on_body_entered(body):
	health -= body.damage
	body.die()
