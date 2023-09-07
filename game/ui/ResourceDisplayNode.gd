class_name ResourceDisplayNode extends Panel

@onready var label = $HBoxContainer/RichTextLabel
@onready var positive_html : String = positive_text.to_html(false)
@onready var negative_html : String = negative_text.to_html(false)

@export var positive_text : Color
@export var negative_text : Color

static var format = "[color=%s] %s %s[/color]"

 


func set_resource():
	pass
	

func update_values(storage : float, income : float) -> void:
	label.text = format_number(storage) + (
		" + 0" if is_zero_approx(income) else format_color(income)
	)
	

# Transform a float into a string with sign and color added
func format_color(x : float) -> String:
	if x > 0:
		return format % [positive_html, "+", format_number(abs(x))]
		
	else:
		return format % [negative_html, "-", format_number(abs(x))]
	

# Transform a float into a string
func format_number(x : float) -> String:
	
	if x < 100:
		return str(snappedf(x, 0.1))
	
	elif x < 1000:
		return str(snappedf(x, 1))
		
	x /= 1000
	
	if x < 100:
		return str(snappedf(x, 0.1)) + "K"
		
	elif x < 1000:
		return str(snappedf(x, 1)) + "K"
	
	x /= 1000
	
	if x < 100000000:
		return str(snappedf(x, 0.1)) + "M"
		
	return str(snappedf(x, 1)) + "M"
