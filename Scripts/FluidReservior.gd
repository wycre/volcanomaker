extends Panel

const Fluids = preload("res://Scripts/Fluids.gd").Fluids


var _fluid_material: StyleBoxFlat
var _fluid_type: Fluids

func _ready() -> void:
	# Clone fluid material from FluidTube
	_fluid_material = get_node("../FluidTube")._fluid_material
	add_theme_stylebox_override("panel", _fluid_material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_color(fluid_type: Fluids):
	_fluid_type = fluid_type
	if fluid_type == Fluids.LAVA:
		_fluid_material.bg_color = Color("f75b1d")
	if fluid_type == Fluids.CHOCO:
		_fluid_material.bg_color = Color("281f07")
	if fluid_type == Fluids.MOLASSES:
		_fluid_material.bg_color = Color("160e01")
