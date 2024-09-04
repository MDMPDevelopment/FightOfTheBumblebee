extends Area2D
class_name Player

signal fire(location, bullet_scene)
signal killed

const BASE_FIRE_RATE = 1.5

var BULLET_SCENE = preload("res://bullet.tscn")
var SCREEN_SIZE = Vector2.ZERO
var SIZE = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	SCREEN_SIZE = get_viewport_rect().size
	SIZE = $CollisionShape2D.shape.get_rect().size
	set_fire_rate(BASE_FIRE_RATE)
	$AnimatedSprite2D.play("fly")

func reset_position():
	position = Vector2((SCREEN_SIZE.x / 2), SCREEN_SIZE.y - SIZE.y - 10)

func start():
	$BulletTimer.start()

func stop():
	$BulletTimer.stop()

func set_fire_rate(newRate):
	$BulletTimer.set_wait_time(newRate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		position += event.relative
		position = position.clamp(SIZE / 2, SCREEN_SIZE - (SIZE / 2))

func _on_bullet_timer_timeout():
	fire.emit(position - Vector2(0, (SIZE.y / 2) + 5), BULLET_SCENE)

func _on_area_entered(area):
	if not area is Bullet:
		killed.emit()
