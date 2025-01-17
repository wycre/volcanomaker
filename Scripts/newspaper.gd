extends Control

const Fluidslib = preload("res://Scripts/Fluids.gd")
const Fluids = Fluidslib.Fluids
const Severity = Fluidslib.Severity
var fluid_descriptions = Fluidslib.fluid_descriptions
var eruption_descriptor = Fluidslib.eruption_descriptor
var town_impact = Fluidslib.town_impact

var town_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_text(fluid_type: Fluids, severity: Severity):
	var headline = ""
	headline += "    The town of " + town_name
	headline += " has been " + town_impact[severity]
	headline += " by a " + eruption_descriptor[severity]
	if severity == Severity.MINOR:
		headline += " sploot of "
	else:
		headline += " eruption of "
	headline += fluid_descriptions[fluid_type]
	$NewspaperText.text = headline
	print(headline)
