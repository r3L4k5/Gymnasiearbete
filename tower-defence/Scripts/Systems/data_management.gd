extends Node
class_name DataManagement


const PATH = "user://td_save_data.json"


func save_data(level: int):
	
	var data = load_data()
	
	data[str(level)] = UI.clock.total_seconds
	
	var json_data = JSON.stringify(data, "\t")
	
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	
	file.store_string(json_data)
	file.close()


func load_data():

	var file = FileAccess.open(PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	return data


func create_new_file(level_amount: int):
	
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	
	var empty_data = {}
	
	for i in range(1, level_amount + 1):
		
		empty_data[i] = 0
	
	var json_data = JSON.stringify(empty_data)
	
	file.store_string(json_data)
	file.close()
