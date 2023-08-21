extends Node

signal day_passed
signal month_passed
signal year_passed

var time : float = 0
var timescale : float = 1
var old_timescale : float = 0

var timer : float = 0
var delta_t : float


class Date:
	
	var overflow : float
	
	var day : int
	var month : int
	var year : int
	var millennium : int
	
	
	
	func _init(d : int = 1, m : int = 1, y : int = 1, ml : int = 1):
		day = d
		month = m
		year = y
		millennium = ml
		
		overflow = 0

	
	# Advance tick system by one day
	func advance():
		TimeController.day_passed.emit()
		if day < 30:
			day += 1
			
		else: # Carry-over day
			day = 1
			TimeController.day_passed.emit()
			if month < 12:
				month += 1
			
			else: # Carry-over month
				month = 1
				TimeController.day_passed.emit()
				if year < 1000:
					year += 1
				
				else: # Carry-over year
					year = 1
					millennium += 1
		
		print(str(month) + "/" + str(day) + "/" + str(year))
					
var current_date : Date


func _ready():
	process_priority = -1
	current_date = Date.new()

func _process(delta):
	if not is_zero_approx(timescale):
		delta_t = delta * timescale
		time += delta_t
		
		timer -= delta
		if timer <= 0:
			timer += (1 / timescale)
			current_date.advance()


# Instance methods
func swap_timescale():
	var temp = timescale
	timescale = old_timescale
	old_timescale = temp
	get_tree().paused = not get_tree().paused


func set_timescale(scale : float):
	if is_zero_approx(timescale):
		old_timescale = 0.0
		get_tree().paused = not get_tree().paused
		
	timescale = scale
	
	
	
	
