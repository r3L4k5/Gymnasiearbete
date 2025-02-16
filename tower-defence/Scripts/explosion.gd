extends CPUParticles2D

@onready var sound = $Sound

func explode():
	
	var duplicate = self.duplicate()
	get_node("/root/Main").add_child(duplicate)
	
	duplicate.global_position = self.global_position
	duplicate.scale = self.scale
	duplicate.emitting = true
	
	duplicate.sound.play()


func _on_finished():
	queue_free()
