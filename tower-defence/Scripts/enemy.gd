extends CharacterBody2D


@onready var explosion = $Explosion

const BASE_DAMAGE: int = 10
const BASE_SPEED: int = 150
const BASE_HEALTH: int = 100
const REWARD: int = 2

var damage: int
var speed: int 
var health: int: 
	set(value):
		health = value
		if health <= 0: 
			die()
			give_reward.emit(REWARD)


var power_level: float 

signal give_reward

func _ready():
	damage = BASE_DAMAGE * power_level
	speed = BASE_SPEED * power_level / 3
	health = BASE_HEALTH * power_level
	
	$PowerLevel.text = str(power_level)

func _physics_process(delta):
	get_parent().progress += delta * speed

func take_damage(damage):
	health -= damage

func die():
	$Explosion.explode()
	get_parent().queue_free()
