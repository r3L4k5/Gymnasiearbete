extends StaticBody2D
class_name Defence


@onready var sprite = $Sprite
@onready var placeable = $Placeable
@onready var upgrade_button: Button = $UpgradeButton

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
	upgrade_button.gui_input.connect(upgrade_button_clicked)
	
	placeable.has_been_placed.connect(func(): upgrade_button.show())


func upgrade_button_clicked(event: InputEvent):
	
	if event.is_action("Left-Click"):
		upgrade()
	
	elif event.is_action("Right-Click"):
		sell()


func upgrade():
	if not get_parent().can_afford(upgrade_cost):
		return false
	
	else:
		level += 1
		$UpgradeSound.play()
		return true


func sell():
	var reimbursment: int = cost * level / 2

	$Notification.notify(reimbursment)
	$Explosion.explode()
	
	get_parent().gain_currency(reimbursment)
	
	self.queue_free()
