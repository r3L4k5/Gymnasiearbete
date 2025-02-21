extends CanvasLayer

const CANNON = preload("res://Scenes/Defences/cannon.tscn")
const HEALER = preload("res://Scenes/Defences/healer.tscn")
const SAW = preload("res://Scenes/Defences/saw.tscn")
const OBSTACLE = preload("res://Scenes/Defences/obstacle.tscn")

@onready var add_defence: VBoxContainer = $AddDefence
@onready var currency: Control = $Currency
@onready var next_level_button: Button = $NextLevelButton
@onready var level: Label = $Level

@onready var screen: Screen = $Screen

@onready var clock = $Time/Clock
@onready var highest_time: Label = $Time/HighestTime
@onready var time_goal: Label = $Time/TimeGoal


func _ready():
	set_up_defence_buttons()

func _process(delta):
	check_enough_currency()

func set_up_defence_buttons():
	var specimen_cannon = CANNON.instantiate()
	add_defence.get_node("Cannon/Button").text = str(specimen_cannon.cost)
	
	var specimen_saw = SAW.instantiate()
	add_defence.get_node("Saw/Button").text = str(specimen_saw.cost)
	
	var specimen_healer = HEALER.instantiate()
	add_defence.get_node("Healer/Button").text = str(specimen_healer.cost)
	
	var specimen_obstacle = OBSTACLE.instantiate()
	add_defence.get_node("Obstacle/Button").text = str(specimen_obstacle.cost)


func check_enough_currency():
	
	for defence in add_defence.get_children():
		
		if int(defence.get_node("Button").text) > int(currency.get_node("Label").text):
			
			defence.get_node("Button").disabled = true
		
		else:
			defence.get_node("Button").disabled = false
