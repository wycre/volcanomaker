extends Panel

const Fluidslib = preload("res://Scripts/Fluids.gd")
const Fluids = Fluidslib.Fluids
const Colors = Fluidslib.fluid_colors



var _fluid_material: StyleBoxFlat
var _fluid_type: Fluids

func _ready() -> void:
	# Clone fluid material from FluidTube
	_fluid_material = get_node("../FluidTube")._fluid_material
	add_theme_stylebox_override("panel", _fluid_material)

func change_color(fluid_type: Fluids):
	_fluid_type = fluid_type
	_fluid_material.bg_color = Colors[fluid_type]
