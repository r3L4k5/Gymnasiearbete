extends Area2D


@export var indicator_position: Vector2 = Vector2(0,0)
@export var indicator_radius: float 
@export var indicator_color: Color = Color("00889c62")
@export var fill_indicator: bool = true


func _draw():
	draw_circle(indicator_position, indicator_radius, indicator_color, fill_indicator)
