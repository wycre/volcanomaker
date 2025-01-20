extends Control

# Fluid Library Import
const Fluidslib = preload("res://Scripts/Fluids.gd")
const Fluids = Fluidslib.Fluids
var Colors = Fluidslib.fluid_colors
var fluid_decay_rates = Fluidslib.fluid_decay_rates
var volcano_textures = Fluidslib.volcano_textures
var town_audio = Fluidslib.town_audio

var _fluid_material = StyleBoxFlat.new()
var _fluid_type: Fluids

var erupted: bool = false
var _eruption_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_fluid(Fluids.LAVA)
	$FluidTube.add_theme_stylebox_override("fill", _fluid_material)
	$FluidReservior.add_theme_stylebox_override("panel", _fluid_material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle Fluid Increase
	if Input.is_action_just_pressed("ui_select") or erupted:
		if $FluidTube.value < 100:
			$FluidTube.value += 3 + (randi() % 6)
		if $FluidTube.value >= 100:
			start_eruption()
	# Handle Fluid Decay
	else:
		$FluidTube.value -= fluid_decay_rates[_fluid_type] * delta

# Begin the eruption process
func start_eruption():
	if not erupted: # Only run once per eruption
		erupted = true
		
		# Stop town growth
		var town = get_node("../TownArea")
		town.timer_active = false
		
		# Swap volcano texture
		$VolcanoSprite.texture = volcano_textures[_fluid_type]
		
		# Set Town Reaction Audio
		$TownReactionPlayer.stream = town_audio[_fluid_type]
		
		# Play Eruption Animation
		$RumblePlayer.play()
		$ExplosionPlayer.play()
		$TownReactionPlayer.play()
		$VolcanoAnimator.play("volcano_shake")
		
		# Start timer
		if not _eruption_timer:
			_eruption_timer = Timer.new()
			_eruption_timer.name = "EruptionTimer"
			add_child(_eruption_timer)
			_eruption_timer.timeout.connect(_complete_eruption)
			_eruption_timer.start(5)

func _complete_eruption():
	$RumblePlayer.stop()
	
	# Display newspaper
	get_node("../Newspaper").display_newspaper()
	
	# Reset volcano appearance
	$VolcanoAnimator.stop()
	
	# Delete the timer
	_eruption_timer.queue_free()

# Resets the volcano to previous state
func reset_volcano():
	$VolcanoSprite.texture = load("res://Assets/Textures/VolcanoBase.png")
	$FluidTube.value = 0

# Handles fluid changing behavior
func change_fluid(fluid_type: Fluids):
	_fluid_type = fluid_type
	_fluid_material.bg_color = Colors[fluid_type]
	
	# Reset eruption progress
	$FluidTube.value = 0
