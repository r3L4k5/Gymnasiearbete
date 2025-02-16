extends Node2D


var defence_dict: Dictionary = {
	"Cannon": load("res://Scenes/Defences/cannon.tscn"),
	"Saw": load("res://Scenes/Defences/saw.tscn"),
	"Healer": load("res://Scenes/Defences/healer.tscn")
}

func _ready():
	UI.add_defence.get_node("Saw/Button").pressed.connect(spawn_defence.bind("Saw"))
	UI.add_defence.get_node("Cannon/Button").pressed.connect(spawn_defence.bind("Cannon"))
	UI.add_defence.get_node("Healer/Button").pressed.connect(spawn_defence.bind("Healer"))


func spawn_defence(defence_name):
	var new_defence = defence_dict[defence_name].instantiate()
	
	if get_parent().currency >= new_defence.cost and spawn_is_empty():
		
		get_parent().currency -= new_defence.cost
		
		new_defence.global_position = $"../Fortress".global_position
		
		self.add_child(new_defence)


func spawn_is_empty():
	if $"../Fortress".get_overlapping_areas().size() == 0:
		return true
	else: 
		return false
