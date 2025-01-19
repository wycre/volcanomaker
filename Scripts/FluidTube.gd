extends ProgressBar

const Fluidslib = preload("res://Scripts/Fluids.gd")
const Fluids = Fluidslib.Fluids
var Colors = Fluidslib.fluid_colors
var fluid_decay_rates = Fluidslib.fluid_decay_rates


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
		value -= fluid_decay_rates[_fluid_type] * delta
		#match _fluid_type:
			#Fluids.LAVA:
				#value -= 1 * delta
			#Fluids.CHOCO:
				#value -= 5 * delta
			#Fluids.MOLASSES:
				#value -= 1 * delta
		

func prepare_erupt():
	if not erupted:
		erupted = true
		# Change game state
		var town = get_node("../../TownArea")
		town.timer_active = false
		
		
		
		# Play Eruption Animation
		$RumblePlayer.play()
		$ExplosionPlayer.play()
		#get_node("../../VolcanoAnimator").play("camera_shake")
		
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
	var newspaper = get_node("../../Newspaper")
	newspaper.visible = true
	
	#get_node("../../VolcanoAnimator").stop()
	
	# Delete the dimer
	eruption_timer.queue_free()
	
	

# Changes the color of the fluid and resets progress
func change_color(fluid_type: Fluids):
	_fluid_type = fluid_type
	_fluid_material.bg_color = Colors[fluid_type]

	# Reset progress when chaning fluid types
	value = 0
