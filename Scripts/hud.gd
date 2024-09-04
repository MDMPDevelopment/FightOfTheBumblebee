extends CanvasLayer

signal start_pressed

var score_label

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label = get_node("MarginContainer/ScoreLabel")
	score_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func print_score(score):
	score_label.text = str(score)

func _on_start_button_pressed():
	score_label.show()
	$Message.hide()
	$StartButton.hide()
	start_pressed.emit()


func _on_main_new_score(newScore):
	print_score(newScore)


func _on_player_killed():
	$Message.text = "GAME OVER"
	$Message.show()
	$StartButton.show()
