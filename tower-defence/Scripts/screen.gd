extends Control
class_name Screen

@onready var buttons = $Buttons

@onready var resume_button = $Buttons/Resume
@onready var restart_button = $Buttons/Restart
@onready var exit_button = $Buttons/Exit
@onready var next_level_button = $Buttons/NextLevel
@onready var retry_button = $Buttons/Retry

@onready var time = $Information/Time
@onready var level = $Information/Level
@onready var title = $Title

signal restart
signal exit
signal next_level
signal retry

enum Scenario {VICTORY, DEFEAT, PAUSE, GOAL, COMPLETE}


func _ready():
	self.hide()

func activate(scenario: Scenario):
	
	if get_tree().paused: return
	 
	self.show()
	get_tree().paused = true

	time.text = "Time: " + UI.clock.display.text
	level.text = UI.level.text
	
	match scenario:
		
		Scenario.VICTORY:
			victory()
		
		Scenario.DEFEAT:
			defeat()
		
		Scenario.PAUSE:
			pause()
		
		Scenario.GOAL:
			goal_reached()
		
		Scenario.COMPLETE:
			level_complete()


func victory():
	title.text = "VICTORY!"
	
	restart_button.show()
	exit_button.show()
	
	$Sound/Victory.play()

func defeat():
	title.text = "DEFEAT!"
	
	restart_button.show()
	exit_button.show()
	
	$Sound/Defeat.play()

func goal_reached():
	title.text = "Goal Reached!"
	
	resume_button.show()
	next_level_button.show()
	
	$Sound/GoalReached.play()

func level_complete():
	title.text = "Level Complete"
	
	retry_button.show()
	next_level_button.show()
	
	$Sound/LevelComplete.play()

func pause():
	title.text = "Paused"
	
	restart_button.show()
	resume_button.show()
	exit_button.show()

func deactivate():
	self.hide()
	
	for button in $Buttons.get_children():
		button.hide()
	
	get_tree().paused = false


func _on_restart_pressed():
	restart.emit()
	deactivate()

func _on_exit_pressed():
	exit.emit()
	deactivate()

func _on_next_level_pressed():
	next_level.emit()
	deactivate()

func _on_retry_pressed():
	retry.emit()
	deactivate()
