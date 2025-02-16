extends Node2D

@onready var area = $Area
@onready var sprite = $Sprite

var mouse_is_hovering: bool = false
var spawn_position: Vector2

var is_placed: bool = false:
	set(value):
		is_placed = value
		has_been_placed.emit()
		get_parent().sprite.modulate = Color("ffffff")

signal has_been_placed
 

func _on_area_mouse_entered():
	mouse_is_hovering = true

func _on_area_mouse_exited():
	if not Input.is_action_pressed("Right-Click") and not mouse_is_hovering:
		mouse_is_hovering = false

func pick_up_defence():
	
	if is_placed:
		return
		
	elif Input.is_action_pressed("Right-Click") and mouse_is_hovering:
		
		get_parent().global_position = get_viewport().get_mouse_position()
		
	elif Input.is_action_just_released("Right-Click") and mouse_is_hovering:
		
		if can_be_placed():
			is_placed = true
		else: 
			create_tween().tween_property(get_parent(), "position", Vector2(0,0), 0.2)


func can_be_placed():
	
	if is_placed:
		return
	
	elif area.get_overlapping_areas().size() > 0:
		get_parent().sprite.modulate = Color("ff3202")
		return false
	
	elif area.get_overlapping_bodies().size() > 0:
		get_parent().sprite.modulate = Color("ff3202")
		return false
	
	else:
		get_parent().sprite.modulate = Color("00ad37")
		return true

func _physics_process(delta):
	can_be_placed()
	pick_up_defence()
