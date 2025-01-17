# All fluid items should share the same order in the following objects
enum Fluids {
	LAVA,
	CHOCO, 
	MOLASSES
}

static var fluid_names = [
	"Lava",
	"Chocolate Syrup",
	"Molasses"
]

static var fluid_colors = [
	Color("f75b1d"),
	Color("281f07"),
	Color("160e01")
]

static var fluid_descriptions = [
	"Hot Lava",
	"Goopy Chocolate Syrup",
	"Sticky Molasses"
]


# These have their own item order independent from the fluid items
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
