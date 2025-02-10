extends Node


var all_levels: Dictionary
var cur_level: int = 0

func _ready():
	for i in range(1, 3):
		all_levels[i] = load("res://Scenes/Levels/level_%s.tscn" % [str(i)])
	
	add_level_to_tree()


func add_level_to_tree():
	if cur_level != 0:
		get_node("Level %s" % [str(cur_level)]).queue_free()
	
	if cur_level < all_levels.size():
		cur_level += 1
		
		var new_level = all_levels[cur_level].instantiate()
		new_level.next_level.connect(add_level_to_tree)
		
		self.add_child(new_level)
	
	else:
		get_tree().paused = true
