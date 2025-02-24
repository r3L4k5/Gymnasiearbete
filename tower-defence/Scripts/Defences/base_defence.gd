extends StaticBody2D
class_name Defence


@onready var sprite = $Sprite
@onready var placeable = $Placeable
@onready var defence_button: Button = $DefenceButton

var level: int = 1:
	set(value):
		level = value
		
		upgraded.emit(upgrade_cost)
		upgrade_cost *= 2
		defence_button.text = str(value)
		
		set_tooltip_text()

@export var cost = 0
@export var upgrade_cost: int = 0
@export var upgrade_rate: float = 1.5

signal upgraded


func _ready():
	defence_button.hide()
	defence_button.gui_input.connect(defence_button_clicked)
	
	set_tooltip_text()
	
	placeable.has_been_placed.connect(func():defence_button.show())


func set_tooltip_text():
	
	var upgrade_text: String = "Upgrade Cost: " + str(upgrade_cost)
	var sell_text: String = "Sell Gain: " + str( cost * level / 2)
	
	defence_button.tooltip_text = upgrade_text + "\n" + sell_text


func defence_button_clicked(event: InputEvent):
	
	if event.is_action_released("Left-Click"):
		upgrade()
	
	elif event.is_action_released("Right-Click"):
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
