extends CanvasLayer

const CANNON = preload("res://Scenes/Defences/cannon.tscn")
const HEALER = preload("res://Scenes/Defences/healer.tscn")
const SAW = preload("res://Scenes/Defences/saw.tscn")

@onready var add_defence = $AddDefence
@onready var clock = $Clock
@onready var currency = $Currency
@onready var time_goal = $TimeGoal
@onready var next_level_button = $NextLevelButton
@onready var level = $Level
@onready var screen = $Screen
@onready var goal_screen = $GoalScreen


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


func check_enough_currency():
	
	if int(add_defence.get_node("Cannon/Button").text) > int(currency.get_node("Label").text):
		add_defence.get_node("Cannon/Button").disabled = true
		
	elif int(add_defence.get_node("Cannon/Button").text) <= int(currency.get_node("Label").text):
		add_defence.get_node("Cannon/Button").disabled = false
	
	
	if int(add_defence.get_node("Saw/Button").text) > int(currency.get_node("Label").text):
		add_defence.get_node("Saw/Button").disabled = true
		
	elif int(add_defence.get_node("Saw/Button").text) <= int(currency.get_node("Label").text):
		add_defence.get_node("Saw/Button").disabled = false
	
	
	if int(add_defence.get_node("Healer/Button").text) > int(currency.get_node("Label").text):
		add_defence.get_node("Healer/Button").disabled = true
		
	elif int(add_defence.get_node("Healer/Button").text) <= int(currency.get_node("Label").text):
		add_defence.get_node("Healer/Button").disabled = false
