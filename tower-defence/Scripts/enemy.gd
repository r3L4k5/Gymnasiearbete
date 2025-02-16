extends CharacterBody2D
class_name Enemy


@export var base_damage: int = 10
@export var base_speed: int = 150
@export var base_health: int = 100
@export var reward: int = 2

var speed: int
var damage: int
var health: int: 
	set(value):
		health = value
		if health <= 0: 
			die()
			give_reward.emit(reward)

var power_level: float 

signal give_reward

func _ready():
	damage = base_damage * power_level
	speed = base_speed * power_level / 3
	health = base_health * power_level
	
	$PowerLevel.text = str(power_level)

func _physics_process(delta):
	get_parent().progress += delta * speed

func take_damage(damage):
	health -= damage

func die():
	$Explosion.explode()
	get_parent().queue_free()
