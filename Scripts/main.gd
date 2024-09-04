extends Node2D
class_name Main

var GLOBAL_RNG = RandomNumberGenerator.new()

enum States { MENU, STAGE, BOSS, GAMEOVER }

signal new_score(newScore)

@export var enemy_spawn_variance = 0.2
@export var enemy_y_variance = 2

@export var enemy_spawn_delay_multiplier = 0.9
@export var base_enemy_spawn_delay = 2.0
var current_enemy_spawn_delay

var current_state = States.MENU
var current_stage = 1

var score = 0

var SCREEN_SIZE = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	SCREEN_SIZE = get_viewport_rect().size
	$Player.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_destroyed(points):
	score += points
	new_score.emit(score)

func _on_enemy_dodged(points):
	score += points
	new_score.emit(score)

func _on_enemy_timer_timeout():
	var to_spawn = $EnemySpawner.spawn(current_stage)
	for enemy_scene in to_spawn:
		var enemy = enemy_scene.instantiate()
		var enemy_size = enemy.get_node("CollisionShape2D").shape.get_rect().size
		
		var enemy_spawn_location = get_node("EnemyPath/EnemySpawnLocation")
		enemy_spawn_location.progress_ratio = randf()
		
		enemy.position = Vector2(enemy_spawn_location.position.x, -enemy_size.y + GLOBAL_RNG.randi_range(-enemy_y_variance * enemy_size.y, 0))
		clamp(enemy.position.x, 0, SCREEN_SIZE.x)
		
		enemy.destroyed.connect(_on_enemy_destroyed)
		enemy.dodged.connect(_on_enemy_dodged)
		
		if enemy.FIRES:
			enemy.fire.connect(_on_fire)
		
		add_child(enemy)
	
	$EnemyTimer.set_wait_time(current_enemy_spawn_delay + GLOBAL_RNG.randf_range(-enemy_spawn_variance, enemy_spawn_variance))

func _on_fire(location, bullet_scene):
	var bullet = bullet_scene.instantiate()
	bullet.position = location
	add_child(bullet)

func _on_player_killed():
	$EnemyTimer.stop()
	$Player.stop()
	$Player.hide()
	get_tree().call_group("Enemies", "queue_free")
	get_tree().call_group("Bullets", "queue_free")

func _on_hud_start_pressed():
	score = 0
	current_stage = 0
	current_enemy_spawn_delay = base_enemy_spawn_delay
	new_score.emit(score)
	
	$Player.reset_position()
	$Player.show()
	$Player.start()
	
	$EnemyTimer.set_wait_time(current_enemy_spawn_delay)
	$EnemyTimer.start()
	$StageTimer.start()


func _on_stage_timer_timeout():
	current_stage += 1
	current_enemy_spawn_delay *= enemy_spawn_delay_multiplier
