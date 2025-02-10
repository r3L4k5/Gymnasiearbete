extends Node2D


var defence_dict: Dictionary = {
	"Canon": load("res://Scenes/canon.tscn"),
	"Saw": load("res://Scenes/saw.tscn"),
	"Healer": load("res://Scenes/healer.tscn")
}

func _ready():
	UI.add_defence.get_node("Saw/Add").pressed.connect(spawn_defence.bind("Saw"))
	UI.add_defence.get_node("Canon/Add").pressed.connect(spawn_defence.bind("Canon"))
	UI.add_defence.get_node("Healer/Add").pressed.connect(spawn_defence.bind("Healer"))


func spawn_defence(defence_name):
	var new_defence = defence_dict[defence_name].instantiate()
	
	if get_parent().currency >= new_defence.COST:
		
		get_parent().currency -= new_defence.COST
		
		new_defence.position = Vector2(0,0)
	
		self.add_child(new_defence)

	
