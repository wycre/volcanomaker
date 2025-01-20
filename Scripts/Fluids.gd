"""
This file contians parameters for game behavior

The groups are:
	- Fluids
	- Destruction Severity

If you add or modify entries for a given group, you must ensure that all items
share the same ordering, and that all entries are of the same length.
For example:
	If `enum Fluids` has 3 entries, then `static var fluid_names` must also have
	3 entries, and in the same order.
	
In general, enums don't have a visual impact on the game, but are necessary for fucntionality,
entries that begin with `static var` or are surrounded with [brackets] will be visible to the player
"""

"""
Fluids Group
"""
enum Fluids {
	LAVA,
	ACID,
	CHOCO, 
	MOLASSES,
}

# Determines the name listed in the fluid picker
static var fluid_names = [
	"Lava",
	"Acid",
	"Chocolate Syrup",
	"Molasses",
]

# Higher numbers means the fluid will drain faster
# If the value is too low, it will not decay at all, this depends on the system, 0.5 is a safe minimum
static var fluid_decay_rates = [
	1,
	5,
	3,
	0.5,
]

# Color of the fluid in a Hex Code
# Color(r,g,b,a) is also allowed with values from 0.0 to 0.1
static var fluid_colors = [
	Color("f75b1d"),
	Color("38f931"),
	Color("281f07"),
	Color("160e01"),
]

static var volcano_textures = [
	load("res://Assets/Textures/VolcanoLava.png"),
	load("res://Assets/Textures/VolcanoAcid.png"),
	load("res://Assets/Textures/VolcanoChoco.png"),
	load("res://Assets/Textures/VolcanoMolasses.png"),
]

static var town_audio = [
	load("res://Assets/Audio/screaming.mp3"),
	load("res://Assets/Audio/acid.mp3"),
	load("res://Assets/Audio/yummy.mp3"),
	load("res://Assets/Audio/molasses.mp3"),
]

# Flavor text description of the fluid used in the newspaper
static var fluid_descriptions = [
	"Hot Lava",
	"Green Acid",
	"Goopy Chocolate Syrup",
	"Sticky Molasses",
]


"""
Destruction Severity
"""
enum Severity {
	MINOR,
	MEDIUM,
	MAJOR,
}

static var eruption_descriptor = [
	"minor",
	"medium",
	"massive"
]

static var town_impact = [
	"incovenienced",
	"soiled",
	"destroyed",
]
