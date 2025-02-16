extends Defence


@onready var charge = $Charge
@onready var range = $Range

@export var shield_conversion: float = 0.33
@export var healing: int = 15
@export var heal_charge_time: float = 5

var heal_release_time: float = 0.3


func release_anim():
	await create_tween().tween_property(self, "modulate", Color("ffffff"), heal_release_time).finished
	
func charge_anim():
	create_tween().tween_property(self, "modulate", Color("00a84c"), heal_charge_time - heal_release_time) 

func heal():
	if not charge.is_stopped():
		return
	
	var fortress = range.get_overlapping_areas()
	
	if fortress.size() > 0 and placeable.is_placed:
		
		fortress[0].gain_health(healing, shield_conversion)
		
		charge.start(heal_charge_time)
		
		await release_anim()
		charge_anim()

func _process(delta):
	heal()

func _on_placeable_has_been_placed():
	charge.start(heal_charge_time)
	charge_anim()

func upgrade():
	if not super.upgrade():
		return
	
	healing *= upgrade_rate
	shield_conversion *= upgrade_rate
	heal_charge_time /= upgrade_rate
