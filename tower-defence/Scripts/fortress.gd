extends Area2D
class_name Fortress


@onready var shield_bar = $ShieldBar
@onready var health_bar = $HealthBar

@export var shield: int = 0 :
	set(value):
		shield = clamp(value, 0, INF)
		shield_bar.value = shield
		
		if shield > max_shield:
			max_shield = shield
		
		if shield == 0:
			shield_bar.hide()
			
		elif shield > 0:
			shield_bar.show()

@export var health: int = 200:
	set(value):
		health = clamp(value, 0, 200)
		health_bar.value = health
		
		if health <= 0:
			fortress_destroyed.emit()

@export var max_health: int = 0

var max_shield: int = 0:
	set(value):
		max_shield = value
		shield_bar.max_value = max_shield

signal fortress_destroyed


var defence_dict: Dictionary = {
	"Cannon": load("res://Scenes/Defences/cannon.tscn"),
	"Saw": load("res://Scenes/Defences/saw.tscn"),
	"Healer": load("res://Scenes/Defences/healer.tscn")
}


func _ready():
	
	shield_bar.hide()
	
	health_bar.max_value = max_health
	health_bar.value = health
	
	shield_bar.max_value = max_shield
	shield_bar.value = shield
	
	UI.add_defence.get_node("Saw/Button").pressed.connect(spawn_defence.bind("Saw"))
	UI.add_defence.get_node("Cannon/Button").pressed.connect(spawn_defence.bind("Cannon"))
	UI.add_defence.get_node("Healer/Button").pressed.connect(spawn_defence.bind("Healer"))


func _on_body_entered(body):
	take_damage(body.damage)
	body.die()

func take_damage(damage):
	if shield == 0:
		health -= damage
	
	elif shield >= damage:
		shield -= damage
	
	else:
		shield = 0
		damage -= shield
		health -= damage

func gain_health(healing, shield_conversion):
	
	if health < max_health:
		
		if health + healing <= max_health:
			health += healing
			return
		
		else:
			health = max_health
			healing -= max_health
			
	shield += int(healing * shield_conversion)
	
	print(health, " ",  shield, " ", max_shield)


#Defence related
func spawn_defence(defence_name):
	
	var new_defence = defence_dict[defence_name].instantiate()
	
	if can_afford(new_defence.cost) and spawn_is_empty():
		
		get_parent().currency -= new_defence.cost
		
		new_defence.upgraded.connect(func(cost): get_parent().currency -= cost)
		
		self.add_child(new_defence)


func spawn_is_empty():
	if get_overlapping_areas().size() == 0:
		return true
	else: 
		return false

func can_afford(cost):
	if get_parent().currency < cost:
		return false
	else:
		return true
