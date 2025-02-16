extends Control

@onready var at_time = $Information/AtTime
@onready var level = $Information/Level

@onready var continue_button= $Buttons/Continue
@onready var next_level = $"Buttons/NextLevel"


func _ready():
	self.hide()

func activate():
	self.show()
	get_tree().paused = true

	at_time.text = "At: " + UI.clock.display.text
	level.text = UI.level.text
	
	$Sound.play()

func deactivate():
	self.hide()
	get_tree().paused = false
