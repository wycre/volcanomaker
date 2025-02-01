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
	MILK,
	MOLASSES,
	BEER,
}

# Determines the name listed in the fluid picker
static var fluid_names = [
	"Lava",
	"Acid",
	"Chocolate Syrup",
	"Milk",
	"Molasses",
	"Beer",
]

# Higher numbers means the fluid will drain faster
# If the value is too low, it will not decay at all, this depends on the system, 0.5 is a safe minimum
static var fluid_decay_rates = [
	1, # lava
	5, # acid
	3, # chocolate syrup
	4, # milk
	0.5, # molasses
	2.5, # beer
]

# Color of the fluid in a Hex Code
# Color(r,g,b,a) is also allowed with values from 0.0 to 0.1
static var fluid_colors = [
	Color("f75b1d"), # lava
	Color("38f931"), # acid
	Color("281f07"), # chocolate syrup
	Color("fff7e0"), # milk
	Color("160e01"), # molasses
	Color("ffda79"), # beer
]

static var volcano_textures = [
	load("res://Assets/Textures/Volcano/VolcanoLava.webp"),
	load("res://Assets/Textures/Volcano/VolcanoAcid.webp"),
	load("res://Assets/Textures/Volcano/VolcanoChoco.webp"),
	load("res://Assets/Textures/Volcano/VolcanoMilk.webp"),
	load("res://Assets/Textures/Volcano/VolcanoMolasses.webp"),
	load("res://Assets/Textures/Volcano/VolcanoBeer.webp"),
]

static var town_audio = [
	load("res://Assets/Audio/screaming.mp3"),
	load("res://Assets/Audio/acid.mp3"),
	load("res://Assets/Audio/yummy.mp3"),
	load("res://Assets/Audio/yummy.mp3"),
	load("res://Assets/Audio/molasses.mp3"),
	load("res://Assets/Audio/burp.mp3"),
]

# Flavor text description of the fluid used in the newspaper
# Format string filling options: {"name": "", "pop": ""}
static var newspaper_body = [
	"{name} has been destroyed after a terrible eruption of lava from the local volcano. Disaster response personell estimate that {pop} people have been impacted by this terrible disaster. Despite the risk, there is still a great deal of interest in the general public to move into {name}.",
	"{name} was hit this week by an eruption of a disolving acid from the local volcano. There were many injuries and the disaster response team reports that {pop} citizens were impacted by this in some way. Efforts to calculate total loss of life and property damage are ongoing.",
	"{name} was impacted by a particularly bizzare eruption from the local volcano today: Chocolate Syrup. There was minor damage to the town, and {pop} citizens have decided to leave, but dieticians are concerned about an uptick in diabetes. Apparently, the citizens of {name} have decided to clean it up using their mouths!",
	"{name} was once again inconvenienced after milk erupted from the local volcano. Despite the minor damage and injuries, {name} is now popular for the bizzare eruptions it regularly faces.",
	"The ground around {name} trembled today as the local volcano erupted a truly incredible amount of molasses. There was major damage to life and property as the sticky substance quickly cooled in our roads and living rooms. People and animals were stuck in the subsance like so many flies on sticky fly-paper.",
	"From the editor at {name} News: Given the nature of the recent disaster, no new article will be published today, all of our staff are drunk.",
]

static var town_destruction = [
	Severity.COMPLETE, # Lava
	Severity.MODERATE, # Acid
	Severity.MINOR, # Chocolate Syrup
	Severity.MINOR, # Milk
	Severity.MAJOR, # Molasses
	Severity.MODERATE # Beer
]


"""
Destruction Severity
"""
enum Severity {
	NONE,
	MINOR,
	MODERATE,
	MAJOR,
	COMPLETE,
}
