extends Area2D
class_name Fly

signal dodged(points)
signal destroyed(points)

const FIRES = false
const DODGED_POINTS = 1
const DESTROYED_POINTS = 2

@export var VELOCITY = 5
var entered_screen = false

# Called when the node enters the scene tree for the first time.
func _ready():
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
