extends Defence

@onready var range = $Range

@export var slowing: float = 0.75
@export var bonus: int = 2

static var weakened_enemies: Array[Enemy]


func weaken_enemy(enemy: Enemy):
	
	for weakened_enemy in weakened_enemies:
		if weakened_enemy == enemy:
			
			return
	
	enemy.speed *= slowing
	enemy.reward *= bonus
	
	weakened_enemies.append(enemy)

func reset_enemy(enemy: Enemy):
	
	enemy.speed = enemy.base_speed * enemy.power_level * 0.1
	enemy.reward /= bonus
	
	for i in range(0, weakened_enemies.size() - 1):
		if weakened_enemies[i] == enemy:
			
			weakened_enemies.remove_at(i)

func _on_range_body_entered(body):
	weaken_enemy(body)

func _on_range_body_exited(body):
	reset_enemy(body)

func upgrade():
	super.upgrade()
	
	slowing *= upgrade_rate
	bonus *= upgrade_rate
