extends ProgressBar

const Fluids = preload("res://Scripts/Fluids.gd").Fluids


var _fluid_material = StyleBoxFlat.new()
var _fluid_type: Fluids

var erupted: bool = false
static var eruption_timer: Timer

func _ready() -> void:
	change_color(Fluids.LAVA) # Default to Lava Color
	add_theme_stylebox_override("fill", _fluid_material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle Fluid Increase
	if Input.is_action_just_pressed("ui_select") or erupted:
		if value < 100:
			value += 3 + (randi() % 6)
		if value >= 100:
			prepare_erupt()
	# Handle Fluid Decay
	else:
		match _fluid_type:
			Fluids.LAVA:
				value -= 1 * delta
			Fluids.CHOCO:
				value -= 5 * delta
			Fluids.MOLASSES:
				value -= 1 * delta
		

func prepare_erupt():
	if not erupted:
		erupted = true
		# Change game state
		var town = get_node("../../TownArea")
		town.timer_active = false
		
		
		
		# Play Eruption Animation
		$RumblePlayer.play()
		$ExplosionPlayer.play()
		
		# Start timer
		if not eruption_timer:
			eruption_timer = Timer.new()
			eruption_timer.name = "EruptionTimer"
			add_child(eruption_timer)
			eruption_timer.timeout.connect(erupt)
			eruption_timer.start(5)
	
	

func erupt():
	$RumblePlayer.stop()
	
	# Display newspaper
	var newspaper_background = get_node("../../NewspaperBackground")
	var newspaper_text = get_node("../../NewspaperText")
	var reset_button = get_node("../../ResetButton")
	newspaper_background.visible = true
	newspaper_text.visible = true
	reset_button.visible = true
	
	# Delete the dimer
	eruption_timer.queue_free()
	
	

# Changes the color of the fluid and resets progress
func change_color(fluid_type: Fluids):
	_fluid_type = fluid_type
	if fluid_type == Fluids.LAVA:
		_fluid_material.bg_color = Color("f75b1d")
	if fluid_type == Fluids.CHOCO:
		_fluid_material.bg_color = Color("281f07")
	if fluid_type == Fluids.MOLASSES:
		_fluid_material.bg_color = Color("160e01")

	# Reset progress when chaning fluid types
	value = 0
