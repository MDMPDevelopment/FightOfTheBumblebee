extends MarginContainer

var safe_area

var top = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	safe_area = DisplayServer.get_display_safe_area()
	top = safe_area.position.y if safe_area.position.y >= top else top
	
	add_theme_constant_override("margin_top", top)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
