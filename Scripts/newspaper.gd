extends Control

const Fluidslib = preload("res://Scripts/Fluids.gd")
const Fluids = Fluidslib.Fluids
const Severity = Fluidslib.Severity
var newspaper_body = Fluidslib.newspaper_body

var town_name: String
var fluid_type: Fluids

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_fluid_type(fluid: Fluids):
	fluid_type = fluid

func display_newspaper():
	$NewspaperText.text = newspaper_body[fluid_type].format({"name": town_name, "pop": str(get_node("../TownArea").population)})
	visible = true
	
func hide_newspaper():
	visible = false
