extends Node


@onready var sound = $Sound

var all_levels: Dictionary

func _ready():
	ready_levels()
	set_up_screens()
	
	sound.play()


func ready_levels():
	for i in range(1, 4):
		all_levels[i] = load("res://Scenes/Levels/level_%s.tscn" % [str(i)])
	
	switch_to_level(1)

func set_up_screens():
	UI.screen.restart.pressed.connect(restart_game)
	UI.screen.quit.pressed.connect(func(): get_tree().quit())
	UI.screen.resume.pressed.connect(func(): get_tree().paused = false)


func switch_to_level(to_level: int):
	#Clear the scene from things that are added to main
	#I.e projectiles, projectiles and notifications as well as the previous level
	for child in get_children():
		if child == sound:
			continue
		else:
			child.queue_free()
	
	if to_level <= all_levels.size():
		
		var new_level = all_levels[to_level].instantiate()
		
		new_level.next_level.connect(switch_to_level)
		new_level.lost.connect(UI.screen.activate.bind("DEFEAT!"))
		
		self.add_child(new_level)
		
		UI.clock.reset_clock()
	
	else:
		UI.screen.activate("VICTORY!")


func _input(event):
	if event.is_action_pressed("Pause") and !get_tree().paused:
		UI.screen.activate("Paused", true)
		
	elif event.is_action_pressed("Pause") and get_tree().paused:
		UI.screen.deactivate()

func restart_game():
	switch_to_level(1)

func _on_sound_finished():
	sound.play()
