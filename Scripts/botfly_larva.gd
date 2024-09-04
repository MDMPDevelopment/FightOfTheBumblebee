extends Area2D
class_name BotflyLarva

const VELOCITY = 10

func _ready():
	$AnimatedSprite2D.play("wriggle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += VELOCITY

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Player:
		hide()
		queue_free()
