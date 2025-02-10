extends CPUParticles2D


func explode():
	var duplicate = self.duplicate()
	
	duplicate.global_position = self.global_position
	duplicate.emitting = true
	
	get_node("/root/Main").add_child(duplicate)

func _on_finished():
	queue_free()
