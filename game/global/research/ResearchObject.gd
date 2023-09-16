class_name ResearchObject extends RefCounted

# Visibility
var hidden : bool = false							# Visibility state
var visibility : Expr					# Conditional expression to be displayed

# Activation
var activation : Expr						# Conditional expression to begin research
var resource_cost : Array[ResourceModifier]			# Monthy resource expense when researching

# Completion
var progress : int									# Research progress
var effect : Array[ExprEffect]						# Effect expression to activate on completion
var resource_effect : Array[ResourceModifier]		# Resource modifier to activate on completion

# Display
var icon : Texture2D
var description : String


func is_complete() -> bool:
	return progress < 1
	

func complete_research() -> void:
	progress = 0
	hidden = false
	
	
	


class EnhanceObject extends ResearchObject:
	pass


class PreceptObject extends ResearchObject:
	pass
