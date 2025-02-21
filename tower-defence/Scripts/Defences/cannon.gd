extends Defence

const PROJECTILE = preload("res://Scenes/Defences/projectile.tscn")

@export var damage: int = 40
@export var projectile_speed: int = 200
@export var shooting_cooldown: float = 1.25

@onready var cooldown = $Cooldown
@onready var range = $Range


func _ready():
	super._ready()
	cooldown.set_wait_time(shooting_cooldown)

func shoot():
	if cooldown.is_stopped():
		
		var projectile = PROJECTILE.instantiate()
		
		projectile.spawn_position = $ShootingPoint.global_position
		projectile.spawn_rotation = $ShootingPoint.global_rotation
		
		projectile.damage = damage
		projectile.speed = projectile_speed
		
		get_node("/root/Main").add_child(projectile)
		
		cooldown.start(shooting_cooldown)


func detect_enemy():
	var enemies = range.get_overlapping_bodies()
	
	if enemies.size() > 0 and placeable.is_placed:
		self.look_at(enemies[0].global_position)
		self.shoot()


func _physics_process(delta):
	detect_enemy()

func open_upgrade_menu():
	UI.upgrade_menu.upgrade_button.pressed.connect(self.upgrade)
	UI.upgrade_menu.set_upgrade_menu("Cannon", 
	{"name": "Damage", "power": damage}, 
	
	{"name": "Speed", "power": projectile_speed},
	
	{"name": "Cooldown", "power": shooting_cooldown})


func upgrade():
	if not super.upgrade():
		return
	
	damage *= upgrade_rate
	projectile_speed *= upgrade_rate
	shooting_cooldown /= upgrade_rate
	
