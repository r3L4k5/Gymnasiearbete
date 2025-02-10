extends Control

signal minute_increase
signal second_increase
signal half_a_minute

var second_counter: int = 0:
	set(value):
		second_counter = value
		if value > 0:
			second_increase.emit()

var minute_counter: int = 0:
	set(value): 
		minute_counter = value
		minute_increase.emit()

func _ready():
	update_timer_display()

func update_timer_display():
	var formatted_seconds: String 
	var formatted_minutes: String 
	
	formatted_seconds = str(second_counter)
	formatted_minutes = str(minute_counter)
	
	if second_counter < 10:
		formatted_seconds = "0" + str(second_counter)
	
	if minute_counter < 10:
		formatted_minutes = "0" + str(minute_counter)
	
	$Display.text = str(formatted_minutes) + ":" + str(formatted_seconds)

func _on_seconds_timer_timeout():
	second_counter += 1
	
	if second_counter == 30:
		half_a_minute.emit()
	
	elif second_counter == 60:
		second_counter = 0
		minute_counter += 1
	
	update_timer_display()

func reset_clock():
	second_counter = 0
	minute_counter = 0
