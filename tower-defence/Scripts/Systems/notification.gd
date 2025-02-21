extends Label


@export var make_sound: bool


func notify(reward: int):
	
	var duplicate = self.duplicate()
	get_node("/root/Main").add_child(duplicate)
	
	duplicate.global_position = self.global_position
	duplicate.text = "+" + str(reward)
	
	duplicate.effect()

func effect():
	self.show()
	
	create_tween().tween_property(self, "position", self.position - Vector2(0, 30), 1)
	create_tween().tween_property(self, "modulate", self.modulate - Color(0, 0, 0, 1), 1)
	
	if make_sound:
		$Sound.play()

func _on_sound_finished():
	queue_free()
