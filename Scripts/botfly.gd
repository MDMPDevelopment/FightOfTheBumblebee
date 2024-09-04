extends Area2D
class_name Botfly

signal dodged(points)
signal destroyed(points)
signal fire(location, bullet)

const FIRES = true
const DODGED_POINTS = 2
const DESTROYED_POINTS = 5

var BULLET_SCENE = preload("res://botfly_larva.tscn")
var SIZE = Vector2.ZERO

@export var VELOCITY = 3
var entered_screen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SIZE = $CollisionShape2D.shape.get_rect().size
	$AnimatedSprite2D.play("fly")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += VELOCITY

func _on_visible_on_screen_notifier_2d_screen_exited():
	if entered_screen:
		dodged.emit(DODGED_POINTS)
		queue_free()

func _on_area_entered(area):
	if not entered_screen:
		pass
	
	if area is Bullet or area is Player:
		hide()
		if area is Bullet:
			destroyed.emit(DESTROYED_POINTS)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	entered_screen = true
	$BulletTimer.start()

func _on_bullet_timer_timeout():
	fire.emit(position + Vector2(0, SIZE.y / 5), BULLET_SCENE)
