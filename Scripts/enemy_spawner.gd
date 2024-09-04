extends Node
class_name EnemySpawner

@export var Fly = preload("res://fly.tscn")
@export var Botfly = preload("res://botfly.tscn")

var ENEMY_PATTERNS = [
	[
		{ "enemy": Fly, "probability": 1, "quantity": 1 }
	],
	[
		{"enemy": Fly, "probability": 0.7, "quantity": 2},
		{"enemy": Botfly, "probability": 0.25, "quantity": 1}
	],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn(stage):
	var enemy_rng = RandomNumberGenerator.new()
	
	var enemy_pattern = ENEMY_PATTERNS[clamp(stage, 0, 9)]
	
	var enemies = []
	for enemy in enemy_pattern:
		for i in range(0, enemy["quantity"]):
			if enemy_rng.randf() <= enemy["probability"]:
				enemies.append(enemy["enemy"])
		
	return enemies
