extends VBoxContainer

@onready var add_defence = $"."

const DEFENCE_FILE_PATH: String = "res://Scripts/Defences/"


func _ready():
	
	var defence_paths

func create_label(name: String):
	var label = Label.new()
	
	label.text = name
	label.add_theme_font_size_override("font_size", 30)
	
	add_defence.add_child(label)

func create_button(cost: int):
	var button = Button.new()
	
	button.text = str(cost)
	
	add_defence.add_child(button)
