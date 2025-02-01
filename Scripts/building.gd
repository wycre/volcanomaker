extends Sprite2D

static var hut_textures = []
static var house_textures = []
static var tower_textures = []

@export_enum("Hut", "House", "Tower") var building_type: int


func _ready() -> void:
	match building_type:
		0:
			if hut_textures.size() == 0:
				get_hut_textures()
			else:
				texture = load(hut_textures[randi() % hut_textures.size()])
		1:
			if house_textures.size() == 0:
				get_house_textures()
			else:
				texture = load(house_textures[randi() % house_textures.size()])
		2:
			if tower_textures.size() == 0:
				get_tower_textures()
			else:
				texture = load(tower_textures[randi() % tower_textures.size()])



func get_hut_textures():
	var dir = DirAccess.open("res://Assets/Textures/Buildings/Hut")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				if file_name.ends_with(".webp"):
					hut_textures.append("res://Assets/Textures/Buildings/Hut/" + file_name)
			file_name = dir.get_next()



func get_house_textures():
	var dir = DirAccess.open("res://Assets/Textures/Buildings/House")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				if file_name.ends_with(".webp"):
					house_textures.append("res://Assets/Textures/Buildings/House/" + file_name)
			file_name = dir.get_next()



func get_tower_textures():
	var dir = DirAccess.open("res://Assets/Textures/Buildings/Tower")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				if file_name.ends_with(".webp"):
					tower_textures.append("res://Assets/Textures/Buildings/Tower/" + file_name)
			file_name = dir.get_next()
