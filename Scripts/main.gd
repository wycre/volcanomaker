extends Control

const Fluids = preload("res://Scripts/Fluids.gd").Fluids


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Bind Fluid choice checkboxes
	var i = 0
	for object in $VolcanoContentButtons.get_children():
		if object is CheckBox:
			object.toggled.connect(_on_radio_toggled.bind(i))
			i += 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_radio_toggled(button_pressed, fluid_type: Fluids):
	if button_pressed:
		# Set Fluid Channel Colors
		$VolcanoGroup/FluidTube.change_color(fluid_type)
		$VolcanoGroup/FluidReservior.change_color(fluid_type)
		
		get_node("NewspaperText")._change_text(name)  # TODO Newspaper Text Engine


# Reset state to begining
func _on_reset_button_pressed() -> void:
	$NewspaperBackground.visible = false
	$NewspaperText.visible = false
	$ResetButton.visible = false
	
	$VolcanoGroup/FluidTube.change_color(Fluids.LAVA)
	$VolcanoGroup/FluidReservior.change_color(Fluids.LAVA)
	
	$VolcanoGroup/FluidTube.erupted = false
	
	for button in $VolcanoContentButtons.get_children():
		if button is CheckBox:
			if button.button_pressed == true:
				button.button_pressed = false
	$VolcanoContentButtons/LavaCheckBox.button_pressed = true
	
	# Restart Population Growth
	$TownArea.reset_pop()
	$TownArea.timer_active = true
	


func test(toggled_on: bool, extra_arg_0: int) -> void:
	pass # Replace with function body.
