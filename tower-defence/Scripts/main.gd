extends Node


@onready var sound = $Sound
@onready var data_management: DataManagement = $DataManagement

const LEVElS_DIR_PATH: String = "res://Scenes/Levels/"

var all_levels: Dictionary = {}
var cur_level: int = 0


func _ready():
	ready_levels()
	set_up_screen_buttons()
	
	sound.play()
	sound.finished.connect(func(): sound.play())
	
	UI.next_level_button.pressed.connect(switch_to_level)


func ready_levels():
	
	var level_paths: Array= DirAccess.get_files_at(LEVElS_DIR_PATH)
	
	for i in range(1, level_paths.size()):
		
		all_levels[i] = load(LEVElS_DIR_PATH + level_paths[i])
	
	switch_to_level(1)


func set_up_screen_buttons():
	UI.screen.next_level.connect(switch_to_level)
	UI.screen.retry.connect(retry_level)
	UI.screen.restart.connect(restart_game)
	UI.screen.exit.connect(exit_game)


func switch_to_level(to_level: int = cur_level + 1):
	
	if cur_level > 0:
		
		handle_high_score(cur_level)
		
		for child in get_children():
			
			if child == sound or child == data_management:
				continue
				
			else:
				child.queue_free()
	
	if to_level <= all_levels.size():
		
		var new_level: Level = all_levels[to_level].instantiate()
		
		new_level.complete.connect(bind_to_screen.bind(Screen.Scenario.COMPLETE))
		new_level.fail.connect(bind_to_screen.bind(Screen.Scenario.DEFEAT))
		
		self.add_child(new_level)
		
		UI.clock.reset_clock()
		UI.highest_time.text = "Highest: " + UI.clock.convert_from_seconds(get_high_score(to_level))
		
		cur_level = to_level
		
	else:
		UI.screen.activate(Screen.Scenario.VICTORY)
	


func bind_to_screen(scenario: Screen.Scenario):
	UI.screen.activate(scenario)

func restart_game():
	switch_to_level(1)

func retry_level():
	switch_to_level(cur_level)

func exit_game():
	handle_high_score(cur_level)
	sound.stop()
	
	get_tree().quit()


func _input(event):
	
	if event.is_action_pressed("Pause") and !get_tree().paused:
		
		UI.screen.activate(Screen.Scenario.PAUSE)
		
	elif event.is_action_pressed("Pause") and get_tree().paused:
		
		UI.screen.deactivate()


#High score management
func handle_high_score(level: int):
	
	if level <= 0: 
		return
	
	if get_high_score(level) < UI.clock.total_seconds:
		
		data_management.save_data(level)

func get_high_score(level: int):
	
	var data = data_management.load_data()
	
	if data == null:
		create_new_file()
		data = data_management.load_data()
	
	elif data.size() < all_levels.size():
		create_new_file()
		data = data_management.load_data()
	
	return int(data[str(level)])

func create_new_file():
	
	var file = FileAccess.open(data_management.PATH, FileAccess.WRITE)
	
	var empty_data = {}
	
	for level in all_levels.keys():
		
		empty_data[level] = "0"
	
	var json_data = JSON.stringify(empty_data)
	
	file.store_string(json_data)
	file.close()
