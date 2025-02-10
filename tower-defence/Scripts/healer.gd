extends StaticBody2D


@onready var cooldown = $Cooldown
@onready var range = $Range

const HEALING: int = 10
const COST: int = 30

func _ready():
	cooldown.start()

func heal():
	if not cooldown.is_stopped():
		return
	
	var fortress = range.get_overlapping_areas()
	
	if fortress.size() > 0:
		fortress[0].health += HEALING
		cooldown.start()

func _process(delta):
	heal()
