@tool
extends Area2D


@onready var collision: CollisionShape2D = $Collision

@export var range_radius: float = 100:
	set(value):
		range_radius = value
		queue_redraw()

@export var range_position: Vector2 = Vector2(0,0)
@export var range_color: Color = Color("00889c3b")

@export var fill_color: bool = false


func _process(delta):
	collision.shape.radius = range_radius


func _draw():
	draw_circle(range_position, range_radius, range_color, fill_color)
