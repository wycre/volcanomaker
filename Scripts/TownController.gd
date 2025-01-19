extends Control

var hut = preload("res://hut.tscn")
var house = preload("res://house.tscn")
var tower = preload("res://tower.tscn")

const building_scale = Vector2(0.3,0.3)
const screenbottom = 755
const screenright = 800

var population: int = 1
var pop_wave: int = 0

var timer_active = true
var timer: float = 0
const timer_limit: float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_hut()

func _process(delta: float) -> void:
	# Increase population in waves, based on a timer
	if timer_active:
		timer += delta
		if timer >= timer_limit:
			pop_wave += 1
			increase_pop(pop_wave)
			timer = 0
		

func increase_pop(wave):
	
	var old_pop = population
	
	population = ceil((1 + (wave ** 1.5)))
	$PopCount.text = str(population)
	
	if (population - old_pop) >= 10:
		print("Adding Tower")
		add_tower()
	elif (population - old_pop) >= 5:
		print("Adding House")
		add_house()
	elif (population - old_pop) >= 1:
		print("Adding Hut")
		add_hut()
	
	
func reset_pop():
	# Reset population counting
	population = 1
	pop_wave = 0
	timer = 0
	$PopCount.text = str(population)
	
	# Reset building state
	for building in get_children():
		if building is Sprite2D:
			building.queue_free()
	add_hut()
	
func add_hut():
	var x = randi() % screenright
	var pos = Vector2(x,screenbottom)
	var instance = hut.instantiate()
	instance.scale = building_scale
	instance.position = pos
	add_child(instance)

func add_house():
	var x = randi() % screenright
	var pos = Vector2(x,screenbottom)
	var instance = house.instantiate()
	instance.scale = building_scale
	instance.position = pos
	add_child(instance)

func add_tower():
	var x = randi() % screenright
	var pos = Vector2(x,screenbottom)
	var instance = tower.instantiate()
	instance.scale = building_scale
	instance.position = pos
	add_child(instance)
