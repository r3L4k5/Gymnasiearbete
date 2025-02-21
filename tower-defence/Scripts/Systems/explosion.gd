extends CPUParticles2D

@export var make_sound: bool


func explode():
	
	var duplicate = self.duplicate()
	get_node("/root/Main").add_child(duplicate)
	
	duplicate.global_position = self.global_position
	duplicate.scale = self.scale
	duplicate.emitting = true
	
	if make_sound:
		duplicate.get_node("Sound").play()


func _on_finished():
	queue_free()
