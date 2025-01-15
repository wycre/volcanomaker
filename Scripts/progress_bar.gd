extends ProgressBar

var sb = StyleBoxFlat.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sb.bg_color = Color("f75b1d") # Default to lava color
	add_theme_stylebox_override("fill", sb)
	get_node("../Reservior").add_theme_stylebox_override("panel", sb)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		if value < 100:
			value += 3 + (randi() % 6)
		if value >= 100:
			var npbg = get_node("../NewspaperBackground")
			var nptxt = get_node("../NewspaperText")
			var rstbtn = get_node("../ResetButton")
			npbg.visible = true
			nptxt.visible = true
			rstbtn.visible = true
		
	pass
	

func _change_color(name):
	if name == "LavaCheckBox":
		sb.bg_color = Color("f75b1d")
	if name == "ChocoCheckBox":
		sb.bg_color = Color("281f07")
	if name == "Molasses":
		sb.bg_color = Color("160e01")
	pass
