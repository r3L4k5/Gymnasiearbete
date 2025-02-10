extends Node2D

const ENEMY = preload("res://Scenes/enemy.tscn")

@onready var path = $"../Path"

var enemy_power_level: float = 1

func _ready():
	UI.clock.minute_increase.connect(_on_clock_minute_increase)
	UI.clock.half_a_minute.connect(_on_clock_half_a_minute)

func spawn_enemy():
	var enemy = ENEMY.instantiate()
	var path_follower = PathFollow2D.new()
	
	enemy.power_level = enemy_power_level
	enemy.give_reward.connect(gain_reward)
	path_follower.rotates = false
	
	path_follower.add_child(enemy)
	get_parent().path.add_child(path_follower)

func _on_clock_minute_increase():
	enemy_power_level += 0.5

func _on_clock_half_a_minute():
	enemy_power_level += 0.5

func _on_spawn_cooldown_timeout():
	spawn_enemy()

func gain_reward(reward: int):
	get_parent().currency += reward
	
