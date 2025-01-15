extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_radio_toggled(button_pressed, name, value):
	# Enable other elements
	$CallToAction.visible = true
	var progbar = get_node("ProgressBar")
	progbar._change_color(name)
	progbar.visible = true
	
	get_node("NewspaperText")._change_text(name)


# Reset state to begining
func _on_reset_button_pressed() -> void:
	$NewspaperBackground.visible = false
	$NewspaperText.visible = false
	$ResetButton.visible = false
	$CallToAction.visible = false
	
	$ProgressBar._change_color("LavaCheckBox")
	$ProgressBar.value = 0
	$ProgressBar.visible = false
	
	for button in $VolcanoContentButtons.get_children():
		if button.button_pressed == true:
			button.button_pressed = false
	
