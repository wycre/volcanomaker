extends Control

const Fluidslib = preload("res://Scripts/Fluids.gd")
const Fluids = Fluidslib.Fluids
const Severity = Fluidslib.Severity
var newspaper_body = Fluidslib.newspaper_body
var fluid_names = Fluidslib.fluid_names

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
	var text = ""
	var past_eruptions = get_node("../TownArea").past_eruptions.keys()
	if past_eruptions.size() > 0:
		text = "After experiencing past eruptions including "
		if past_eruptions.size() == 1:
			text += fluid_names[past_eruptions[0]] + ", "
		elif past_eruptions.size() == 2:
			text += fluid_names[past_eruptions[0]] + " and " + fluid_names[past_eruptions[1]] + ", "
		else:
			for i in past_eruptions.size():
				
				if i == past_eruptions.size() - 1:
					text += "and " + fluid_names[past_eruptions[i]] + ", "
				else:
					text += fluid_names[past_eruptions[i]] + ", "
				
		
	
	text += newspaper_body[fluid_type].format({"name": town_name, "pop": str(get_node("../TownArea").population)})
	$NewspaperText.text = text
	visible = true
	
func hide_newspaper():
	visible = false
