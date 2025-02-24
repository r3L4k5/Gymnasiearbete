extends Node2D
class_name Level


@onready var path = $Path
@onready var fortress = $Fortress
@onready var enemy_spawner = $EnemySpawner
@onready var defence_spawner = $DefenceSpawner


@export var level_number: int = 0
@export var time_goal: Dictionary = {"minutes": 0, "seconds": 0}
@export var currency: int = 150: 
	set(value):
		currency = value
		UI.currency.get_node("Label").text = str(value)


var has_reached_goal: bool = false:
	set(value):
		has_reached_goal = value
		UI.next_level_button.show()
		UI.screen.activate(Screen.Scenario.GOAL)


signal complete
signal fail


func _ready():
	
	set_up_UI()
	
	fortress.fortress_destroyed.connect(_on_fortress_destroyed)
	
	if get_node("UI") != null:
		remove_child(get_node("UI"))
	
	set_time_goal()


func set_time_goal():
	
	var time_goal_seconds: int = UI.clock.convert_to_seconds(time_goal["minutes"], time_goal["seconds"])
	
	UI.time_goal.text = "Goal: " + UI.clock.convert_from_seconds(time_goal_seconds)


func set_up_UI():
	
	UI.next_level_button.hide()
	
	UI.currency.get_node("Label").text = str(currency)
	
	UI.level.text = "Level: %s" % str(level_number)
	
	set_time_goal()


func _process(delta):
	check_goal()

func check_goal():
	
	if has_reached_goal:
		return
	
	var goal_in_seconds: int = UI.clock.convert_to_seconds(time_goal["minutes"], time_goal["seconds"])
	var formatted_goal: String = UI.clock.convert_from_seconds(goal_in_seconds)
	
	if formatted_goal == UI.clock.display.text:
		
		has_reached_goal = true


func _on_fortress_destroyed():
	if has_reached_goal:
		complete.emit()
	else:
		fail.emit()
