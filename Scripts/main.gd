extends Control

const Fluidslib = preload("res://Scripts/Fluids.gd")
const Fluids = Fluidslib.Fluids
var fluid_names = Fluidslib.fluid_names
var fluid_descriptions = Fluidslib.fluid_descriptions

var checkbox = preload("res://check_box.tscn")
var button_group = preload("res://LavaTypeGroup.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create Fluid Checkboxes
	for i in fluid_names.size():
		var button = checkbox.instantiate()
		button.text = fluid_names[i]
		button.button_group = button_group
		button.button_group.allow_unpress = false
		$VolcanoSettings/VolcanoContentButtons.add_child(button)
		
	
	# Bind Fluid choice checkboxes
	var i = 0
	var all_buttons = $VolcanoSettings/VolcanoContentButtons.get_children()
	for button in all_buttons:
		if button is CheckBox:
			button.toggled.connect(_on_radio_toggled.bind(i))
			i += 1
	
	# Turn on first button
	all_buttons[0].button_pressed = true
	all_buttons[0].emit_signal("toggled", true)
	
	
	# Prepare Town & Data
	set_town_name()
	#$Newspaper.set_text(Fluids.LAVA, 2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_radio_toggled(button_pressed, fluid_type: Fluids):
	if button_pressed:
		# Set Fluid Channel Colors
		$VolcanoGroup/FluidTube.change_color(fluid_type)
		$VolcanoGroup/FluidReservior.change_color(fluid_type)
		
		$Newspaper.set_text(fluid_type, randi() % fluid_descriptions.size())


# Reset state to begining
func _on_reset_button_pressed() -> void:
	$Newspaper.visible = false
	
	$VolcanoGroup/FluidTube.change_color(Fluids.LAVA)
	$VolcanoGroup/FluidReservior.change_color(Fluids.LAVA)
	
	$VolcanoGroup/FluidTube.erupted = false
	
	var buttons = $VolcanoSettings/VolcanoContentButtons.get_children()
	for button in buttons:
		if button is CheckBox:
			if button.button_pressed == true:
				button.button_pressed = false
	buttons[0].button_pressed = true
	
	
	# Reset Town
	$TownArea.reset_pop()
	$TownArea.timer_active = true
	set_town_name()
	buttons[0].emit_signal("toggled", true)
	

func set_town_name():
	var names = []
	var name_file = FileAccess.open("res://Text/town-names.txt", FileAccess.READ)
	while not name_file.eof_reached():
		var line = name_file.get_line()
		names.append(line)
	var chosen_name = names[randi() % names.size()]
	$Newspaper.town_name = chosen_name
	get_node("TownArea/TownName").text = "Town Name: " + chosen_name
