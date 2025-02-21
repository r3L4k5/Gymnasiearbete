extends Control
class_name Clock


@onready var seconds_timer = $SecondsTimer
@onready var display = $Display


var total_seconds: int = 0 :
	set(value):
		
		total_seconds = value
		
		if value <= 0:
			return
		
		if value % 30 == 0:
			half_a_minute.emit()
		
		elif value % 60 == 0:
			minute_increase.emit()
		
		second_increase.emit()


signal minute_increase
signal second_increase
signal half_a_minute


func _process(delta):
	display.text = convert_from_seconds(total_seconds)

func _on_seconds_timer_timeout():
	total_seconds += 1

func reset_clock():
	total_seconds = 0

func convert_from_seconds(seconds: int) -> String:
	
	var minute_counter: int = seconds / 60
	var second_counter: int = seconds % 60
	
	var formatted_minutes: String = str(minute_counter)
	var formatted_seconds: String = str(second_counter)
	
	if second_counter < 10:
		formatted_seconds = "0" + formatted_seconds
	
	if minute_counter < 10:
		formatted_minutes = "0" + formatted_minutes
	
	return formatted_minutes + ":" + formatted_seconds 


func convert_to_seconds(minutes: int, seconds: int):
	return minutes * 60 + seconds
