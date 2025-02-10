extends Node2D


@onready var path = $Path
@onready var fortress = $Fortress
@onready var enemy_spawner = $EnemySpawner
@onready var defence_spawner = $DefenceSpawner

@export var time_goal: Dictionary = {"minutes": 0, "seconds": 0}
@export var currency: int : 
	set(value):
		currency = value
		UI.get_node("Currency/Label").text = str(value)

signal next_level

func _ready():
	fortress.fortress_destroyed.connect(_on_fortress_destroyed)
	set_time_goal()

func set_time_goal():
	var minute_goal: String = str(time_goal["minutes"])
	var second_goal: String = str(time_goal["seconds"])
	
	if time_goal["minutes"] < 10:
		minute_goal = "0" + minute_goal
	
	if time_goal["seconds"] < 10:
		second_goal = "0" + second_goal
	
	UI.time_goal.text = "Goal: "  + minute_goal + ":" + second_goal


func has_reached_goal():
	if UI.clock.minute_counter != time_goal["minutes"]:
		return false
	
	elif UI.clock.second_counter != time_goal["seconds"]:
		return false
	
	else:
		return true

func _on_fortress_destroyed():
	if has_reached_goal():
		next_level.emit()
		UI.clock.reset_clock()
	else:
		get_tree().quit()
