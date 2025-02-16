extends StaticBody2D
class_name Defence


@onready var sprite = $Sprite
@onready var placeable = $Placeable
@onready var upgrade_button = $UpgradeButton

var level: int = 1:
	set(value):
		level = value
		upgraded.emit(upgrade_cost)
		upgrade_cost *= 2
		upgrade_button.text = str(value)
		upgrade_button.tooltip_text = "Upgrade Cost: " + str(upgrade_cost)

@export var cost = 0
@export var upgrade_cost: int = 0
@export var upgrade_rate: float = 1.5

signal upgraded

func _ready():
	upgrade_button.hide()
	upgrade_button.tooltip_text = "Upgrade Cost: " + str(upgrade_cost)
	upgrade_button.pressed.connect(upgrade)
	
	placeable.has_been_placed.connect(func(): upgrade_button.show())


func upgrade():
	if not get_parent().can_afford(upgrade_cost):
		return false
	else:
		level += 1
		$UpgradeSound.play()
		return true
