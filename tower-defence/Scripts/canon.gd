extends StaticBody2D

const PROJECTILE = preload("res://Scenes/projectile.tscn")
const CANON = preload("res://Scenes/canon.tscn")

const DAMAGE: int = 50
const PROJETILE_SPEED: int = 200
const SHOOTING_COOLDOWN: float = 1.25

const COST = 10

@onready var placeable = $Placeable
@onready var cooldown = $Cooldown


func _ready():
	placeable.spawn_position = self.global_position
	cooldown.set_wait_time(SHOOTING_COOLDOWN)

func shoot():
	if cooldown.is_stopped():
		
		var projectile = PROJECTILE.instantiate()
		
		projectile.spawn_position = $ShootingPoint.global_position
		projectile.spawn_rotation = $ShootingPoint.global_rotation
		
		projectile.damage = DAMAGE
		projectile.speed = PROJETILE_SPEED
		
		get_node("/root/Main").add_child(projectile)
		
		cooldown.start()

func detect_enemy():
	var enemies = $Range.get_overlapping_bodies()
	
	if enemies.size() > 0 and placeable.is_placed:
		self.look_at(enemies[0].global_position)
		self.shoot()

func _physics_process(delta):
	detect_enemy()
