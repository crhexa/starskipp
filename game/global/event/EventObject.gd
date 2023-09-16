class_name EventObject extends RefCounted

class EventResponse:
	var text : String								# Displayed in dialog responses
	var tooltip : String							# Displayed when hovering over response
	var condition : Expr							# Condition for allowing response selection/display
	var effect : Array[ExprEffect]					
	var resource_effect : Array[ResourceModifier]
	
	func execute_response() -> void:
		return


# Activation
var executed = false
var trigger : Expr								# Condition for automatic activation
var mtte : int									# Mean time to execution in days after activating
var responses : Array[EventResponse]

# Display
var image : Texture2D
var text : String


func execute() -> void:
	executed = true
