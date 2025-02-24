extends Node2D

const ENEMY = preload("res://Scenes/enemy.tscn")

@onready var spawn_cooldown = $SpawnCooldown

@export var path: Path2D

const spawn_multiplier: int = 3

var enemy_power_level: float = 1


func _ready():
	UI.clock.half_a_minute.connect(_on_clock_half_a_minute)
	set_cooldown()

func spawn_enemy():
	var enemy: Enemy = ENEMY.instantiate()
	var path_follower = PathFollow2D.new()
	
	enemy.power_level = enemy_power_level
	enemy.give_reward.connect(gain_reward)
	
	path_follower.rotates = false
	path_follower.add_child(enemy)
	
	path_follower.position = $SpawnPoint.position
	
	get_parent().path.add_child(path_follower)
	
	set_cooldown()

func _on_clock_half_a_minute():
	enemy_power_level += 1

func set_cooldown():
	var cooldown_time: float = randf_range(0.1, 2) / (enemy_power_level)
	spawn_cooldown.start(cooldown_time)

func gain_reward(reward: int):
	get_parent().currency += reward
