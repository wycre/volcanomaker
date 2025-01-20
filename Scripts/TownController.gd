extends Control

const Fluidslib = preload("res://Scripts/Fluids.gd")
const Severity = Fluidslib.Severity

var hut = preload("res://hut.tscn")
var house = preload("res://house.tscn")
var tower = preload("res://tower.tscn")

const building_scale = Vector2(0.3,0.3)
const screenbottom = 755
const screenright = 800

var population: int = 2
var pop_wave: int = 1

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
		add_tower()
	elif (population - old_pop) >= 5:
		add_house()
	elif (population - old_pop) >= 1:
		add_hut()
		
	
	
func reset_pop():
	# Reset population counting
	population = 1
	pop_wave = 1
	timer = 0
	$PopCount.text = str(population)
	
	# Reset building state
	for building in $Buildings.get_children():
		building.queue_free()
	add_hut()

## Apply some damage to the town
func damage_town(impact: Severity):
	print(impact)
	
	var all_buildings = $Buildings.get_children()
	all_buildings.shuffle()
	
	var old_wave = pop_wave
	
	match impact:
		Severity.NONE: pass # Do nothing
		Severity.MINOR:
			population = ceil(population * 0.75)
			pop_wave = ceil(pop_wave * 0.75)
		Severity.MODERATE:
			population = ceil(population * 0.5)
			pop_wave = ceil(pop_wave * 0.5)
		Severity.MAJOR:
			population = ceil(population * 0.25)
			pop_wave = ceil(pop_wave * 0.25)
		Severity.COMPLETE: 
			reset_pop()
				
	var delta = old_wave - pop_wave
	for i in delta:
		all_buildings.pop_back().queue_free()
	
	$PopCount.text = str(population)
	timer = 0

func add_hut():
	var x = randi() % screenright
	var pos = Vector2(x,screenbottom)
	var instance = hut.instantiate()
	instance.scale = building_scale
	instance.position = pos
	$Buildings.add_child(instance)

func add_house():
	var x = randi() % screenright
	var pos = Vector2(x,screenbottom)
	var instance = house.instantiate()
	instance.scale = building_scale
	instance.position = pos
	$Buildings.add_child(instance)

func add_tower():
	var x = randi() % screenright
	var pos = Vector2(x,screenbottom)
	var instance = tower.instantiate()
	instance.scale = building_scale
	instance.position = pos
	add_child(instance)
	$Buildings.add_child(instance)
