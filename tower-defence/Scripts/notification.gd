extends Label


func notify(reward: int):
	var duplicate = self.duplicate()
	
	duplicate.global_position = self.global_position
	duplicate.text = "+" + str(reward)
	
	get_node("/root/Main").add_child(duplicate)
	
	duplicate.effect()

func effect():
	self.show()
	
	var position_tween = create_tween()
	var opacity_tween = create_tween()
	
	position_tween.tween_property(self, "global_position", self.global_position - Vector2(0, 30), 1)
	opacity_tween.tween_property(self, "modulate", self.modulate - Color(0, 0, 0, 1), 1)
