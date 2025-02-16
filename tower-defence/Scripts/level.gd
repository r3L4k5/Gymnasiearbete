extends Node2D



@onready var path = $Path
@onready var fortress = $Fortress
@onready var enemy_spawner = $EnemySpawner
@onready var defence_spawner = $DefenceSpawner

@export var level_number: int = 0
@export var time_goal: Dictionary = {"minutes": 0, "seconds": 0}
@export var currency: int = 40: 
	set(value):
		currency = value
		UI.currency.get_node("Label").text = str(value)

var has_reached_goal: bool = false:
	set(value):
		has_reached_goal = value
		UI.next_level_button.disabled = false
		UI.goal_screen.activate()

signal next_level
signal lost


func _ready():
	UI.next_level_button.disabled = true
	
	UI.next_level_button.pressed.connect(func(): next_level.emit(level_number + 1))
	UI.goal_screen.next_level.pressed.connect(func(): next_level.emit(level_number + 1))
	
	UI.currency.get_node("Label").text = str(currency)
	UI.level.text = "Level: %s" % str(level_number)
	
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


func _process(delta):
	check_goal()

func check_goal():
	if has_reached_goal:
		return
	
	elif UI.clock.minute_counter != time_goal["minutes"]:
		return false
	
	elif UI.clock.second_counter != time_goal["seconds"]:
		return false
	
	else:
		has_reached_goal = true


func _on_fortress_destroyed():
	if has_reached_goal:
		next_level.emit(level_number + 1)
	else:
		lost.emit()
