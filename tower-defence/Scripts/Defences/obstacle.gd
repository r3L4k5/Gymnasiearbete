extends Defence

@onready var range = $Range

@export var slowing: float = 1.2
@export var accumilation_increment: float = 0.33

var accumilation: float = 0

static var slowed_enemies: Array[Enemy]


func handle_accumilation():
	
	if accumilation >= 1:
		
		get_parent().gain_currency(accumilation)
		$Notification.notify(accumilation)
		
		accumilation = 0
		
	else:
		accumilation += accumilation_increment


func slow_enemy(enemy: Enemy):
	
	for slowed_enemy in slowed_enemies:
		if slowed_enemy == enemy:
			
			return
	
	enemy.speed /= slowing
	slowed_enemies.append(enemy)
	
	handle_accumilation()


func reset_enemy(enemy: Enemy):
	
	enemy.speed = enemy.base_speed * enemy.power_level * 0.1
	
	for i in range(0, slowed_enemies.size() - 1):
		if slowed_enemies[i] == enemy:
			
			slowed_enemies.remove_at(i)


func _on_range_body_entered(body):
	if placeable.is_placed:
		slow_enemy(body)

func _on_range_body_exited(body):
	reset_enemy(body)


func upgrade():
	if not super.upgrade():
		return
	
	slowing *= upgrade_rate 
	accumilation_increment *= upgrade_rate
