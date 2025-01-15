extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _change_text(name):
	var file
	if name == "LavaCheckBox":
		file = FileAccess.open("res://Text/lava.txt", FileAccess.READ)
		text = file.get_as_text()
	if name == "ChocoCheckBox":
		file = FileAccess.open("res://Text/choco.txt", FileAccess.READ)
		text = file.get_as_text()
	if name == "Molasses":
		file = FileAccess.open("res://Text/molasses.txt", FileAccess.READ)
		text = file.get_as_text()
	pass
