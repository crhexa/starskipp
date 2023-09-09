extends VBoxContainer

@onready var label = $TopTime/RichTextLabel
const format = "[center]%d %s %04d"


func _ready():
	Signals.day_passed.connect(_on_day_passed)


func _on_day_passed():
	update_time(TimeController.current_date)
	
	
func update_time(date : TimeController.Date):
	label.text = format % [date.day, month_to_string(date.month), date.year]


func month_to_string(month : int) -> String:
	match month:
		1:
			return "Jan"
		2:
			return "Feb"
		3:
			return "Mar"
		4:
			return "Apr"
		5:
			return "May"
		6:
			return "Jun"
		7:
			return "Jul"
		8:
			return "Aug"
		9:
			return "Sep"
		10:
			return "Oct"
		11:
			return "Nov"
		12:
			return "Dec"
		_:
			return "ERR"
