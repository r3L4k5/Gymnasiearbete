extends Node


@onready var data_management: DataManagement = $DataManagement
@onready var background: Panel = $Background

const LEVElS_PATH: String = "res://Scenes/Levels/level_"
const LEVEL_AMOUNT: int = 4

var all_levels: Dictionary = {}
var cur_level: int = 0


func _ready():
	ready_levels()
	connect_UI_buttons()
	start_menu()


func ready_levels():
	
	for i in range(1, LEVEL_AMOUNT + 1):
		
		all_levels[i] = load(LEVElS_PATH + str(i) + ".tscn")


func connect_UI_buttons():
	
	UI.screen.next_level.connect(switch_to_level)
	UI.screen.retry.connect(retry_level)
	UI.screen.restart.connect(restart_game)
	UI.screen.quit.connect(start_menu)
	
	UI.main_menu.get_node("Buttons/Play").pressed.connect(play_game)
	UI.main_menu.get_node("Buttons/Exit").pressed.connect(exit_game)
	
	UI.next_level_button.pressed.connect(switch_to_level)


func switch_to_level(to_level: int = cur_level + 1):
	
	if cur_level > 0 or to_level == 0:
		
		handle_high_score(cur_level)
		clean_main_scene()
	
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


func clean_main_scene():
	
	for child in get_children():
		
		if child.is_in_group("Essentials"):
			continue
		
		else:
			child.queue_free()


func bind_to_screen(scenario: Screen.Scenario):
	UI.screen.activate(scenario)

#Screen button functions
func restart_game():
	switch_to_level(1)

func retry_level():
	switch_to_level(cur_level)

func exit_game():
	handle_high_score(cur_level)
	get_tree().quit()

func start_menu():
	get_tree().paused = true
	UI.main_menu.show()
	
	$Sound/MainMenu.play()
	$Sound/Background.stop()
	

func play_game():
	get_tree().paused = false
	
	UI.main_menu.hide()
	switch_to_level(1)
	
	$Sound/Background.play()
	$Sound/MainMenu.stop()


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
		
		data_management.create_new_file(LEVEL_AMOUNT)
		data = data_management.load_data()
	
	elif data.size() < all_levels.size():
		
		data_management.create_new_file(LEVEL_AMOUNT)
		data = data_management.load_data()
	
	return data[str(level)]
