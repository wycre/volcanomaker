extends Sprite2D

static var textures = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if textures.size() == 0:
		var dir = DirAccess.open("res://Assets/Textures/Buildings/Hut")
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if !dir.current_is_dir():
					if file_name.ends_with(".png"):
						print(file_name)
						textures.append("res://Assets/Textures/Buildings/Hut/" + file_name)
				file_name = dir.get_next()
					
	texture = load(textures[randi() % textures.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
