extends Control


@onready var restart = $Buttons/Restart
@onready var quit = $Buttons/Quit
@onready var time = $Information/Time
@onready var level = $Information/Level


func activate():
	self.show()
	get_tree().paused = true
	
	time.text = "Time: " + UI.clock.display.text
	level.text = UI.level.text


func deactivate():
	self.hide()
