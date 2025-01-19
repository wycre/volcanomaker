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
	#for i in fluid_names.size():
		#var button = checkbox.instantiate()
		#button.text = fluid_names[i]
		#button.button_group = button_group
		#button.button_group.allow_unpress = false
		#$VolcanoSettings/VolcanoContentButtons.add_child(button)
	var button = checkbox.instantiate()
	button.text = fluid_names[Fluids.LAVA]
	button.button_group = button_group
	button.button_group.allow_unpress = false
	$VolcanoSettings/VolcanoContentButtons.add_child(button)
	button.toggled.connect(_on_radio_toggled.bind(Fluids.LAVA))
		
	
	# Bind Fluid choice checkboxes
	#var i = 0
	var all_buttons = $VolcanoSettings/VolcanoContentButtons.get_children()
	#for button in all_buttons:
		#if button is CheckBox:
			#button.toggled.connect(_on_radio_toggled.bind(i))
			#i += 1
	
	# Prepare Town & Data
	set_town_name()
	
	# Turn on first button
	all_buttons[0].button_pressed = true
	all_buttons[0].emit_signal("toggled", true)


func _on_radio_toggled(button_pressed, fluid_type: Fluids):
	if button_pressed:
		# Set Fluid Channel Colors
		$Volcano.change_fluid(fluid_type)
		
		$Newspaper.set_text(fluid_type, randi() % fluid_descriptions.size())


# Reset state to begining
func _on_reset_button_pressed() -> void:
	
	$Newspaper.visible = false
	$Volcano.erupted = false
	
	# Reset selection on all buttons
	var buttons = $VolcanoSettings/VolcanoContentButtons.get_children()
	for button in buttons:
		if button is CheckBox:
			if button.button_pressed == true:
				button.button_pressed = false
	
	
	# Reset Town
	$TownArea.reset_pop()
	$TownArea.timer_active = true
	set_town_name()
	
	# Add new button
	if buttons.size() < fluid_names.size():
		var button = checkbox.instantiate()
		button.text = fluid_names[buttons.size()]
		button.button_group = button_group
		button.button_group.allow_unpress = false
		$VolcanoSettings/VolcanoContentButtons.add_child(button)
		button.toggled.connect(_on_radio_toggled.bind(buttons.size()))
		# Automatically select the new button
		button.button_pressed = true
		button.emit_signal("toggled", true)
	else: # If there are no new buttons to add
		buttons[0].button_pressed = true
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

	
		
		
		
