extends Area2D
class_name Bullet

const VELOCITY = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("fly")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= VELOCITY


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if not area is Player and not area.is_in_group("Bullets"):
		hide()
		queue_free()
