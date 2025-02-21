extends Node
class_name DataManagement


const PATH = "user://td_save_data.json"


func save_data(level: int):
	
	var data = load_data()
	
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	
	data[str(level)] = UI.clock.total_seconds
	
	var json_data = JSON.stringify(data, "\t")
	
	file.store_string(json_data)
	file.close()


func load_data():

	var file = FileAccess.open(PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	return data
