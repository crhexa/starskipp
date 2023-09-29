extends Node

const operators = [
	"NOT", "AND", "OR", "GT", "GTE", "LT", "LTE", "EQ", "NE",
	"HAS_RESEARCH", "HAS_EVENT", "HAS_PLAYER_FLAG", "HAS_SYSTEM_FLAG", "HAS_PLANET_FLAG", "INT", "FLOAT"
]

const effect_operators = [
	"SET_RESEARCH_HIDDEN", "SET_RESEARCH_VISIBLE", "ACTIVATE_EVENT"
]


const ops_pattern = "(\\w+)\\((.*)\\)"
const arg_pattern = "(\\w+\\((?:[^()]|(?R))*\\)),(\\w+\\((?:[^()]|(?R))*\\))"
static var match_operation : RegEx
static var match_arguments : RegEx


func _init():
	var err : Error
	match_operation = RegEx.new()
	match_arguments = RegEx.new()
	
	err = match_operation.compile(ops_pattern)
	if err != OK:
		push_error("Invalid regex pattern for Expr: operations")
		
	err = match_arguments.compile(arg_pattern)
	if err != OK:
		push_error("Invalid regex pattern for Expr: arguments")


# Parse a string into an Expr tree
func parse(expr_str : String) -> Expr:
	if expr_str.is_empty():
		return Expr.TRUE.new()
	
	var result : RegExMatch = match_operation.search(expr_str)
	var operand : String = result.get_string(1)
	var inner : String = result.get_string(2)
	
	if operand.is_empty() or inner.is_empty() or not operators.has(operand):
		push_error("Failed to parse string into Expr")
		return null
	
	# Single arg
	if operand == "NOT":
		return Expr.NOT.new(parse(inner))
		
	elif operand == "INT":
		return Expr.INT.new(int(inner))
		
	elif operand == "FLOAT":
		return Expr.FLOAT.new(float(inner))
	
	elif operand == "HAS_RESEARCH":
		return Expr.HAS_RESEARCH.new(inner)
		
	elif operand == "HAS_EVENT":
		return Expr.HAS_EVENT.new(inner)
		
	elif operand == "HAS_PLAYER_FLAG":
		return Expr.HAS_PLANET_FLAG.new(inner)
		
	elif operand == "HAS_SYSTEM_FLAG":
		return Expr.HAS_SYSTEM_FLAG.new(inner)
		
	elif operand == "HAS_PLANET_FLAG":
		return Expr.HAS_PLANET_FLAG.new(inner)
		
	elif operand == "GET_SYSTEM_RESOURCE":
		return Expr.GET_SYSTEM_RESOURCE.new(inner)
		
		
	# Look for two arguments separated by a comma
	result = match_arguments.search(inner)
	var arg1 : String = result.get_string(1)
	var arg2 : String = result.get_string(2)
	
	if arg1.is_empty() or arg2.is_empty():
		push_error("Failed to parse Expr: missing argument(s)")
		return null
	
	
	# Double args
	if operand == "AND":
		return Expr.AND.new(parse(arg1), parse(arg2))
	
	elif operand == "OR":
		return Expr.OR.new(parse(arg1), parse(arg2))
		
	elif operand == "GT":
		return Expr.GT.new(parse(arg1), parse(arg2))
		
	elif operand == "GTE":
		return Expr.GTE.new(parse(arg1), parse(arg2))
		
	elif operand == "LT":
		return Expr.LT.new(parse(arg1), parse(arg2))
	
	elif operand == "LTE":
		return Expr.LTE.new(parse(arg1), parse(arg2))

	elif operand == "EQ":
		return Expr.EQ.new(parse(arg1), parse(arg2))
	
	elif operand == "NE":
		return Expr.NE.new(parse(arg1), parse(arg2))

	return null


func parse_effects(effect_strs : Array) -> Array[ExprEffect]:
	var results : Array[ExprEffect] = []
	
	for effect_str in effect_strs:
		var effect = parse_effect(effect_str)
		if effect != null:
			results.push_back(effect)
	
	return results
	
	
# Parse a string into an ExprEffect tree
func parse_effect(effect_str : String) -> ExprEffect:
	var result : RegExMatch = match_operation.search(effect_str)
	var operand : String = result.get_string(1)
	var inner : String = result.get_string(2)
	
	if operand.is_empty() or inner.is_empty() or not effect_operators.has(operand):
		push_error("Failed to parse string into ExprEffect")
		return null
		
	if operand == "SET_RESEARCH_HIDDEN":
		return ExprEffect.SET_RESEARCH_HIDDEN.new(inner)
		
	if operand == "SET_RESEARCH_VISIBLE":
		return ExprEffect.SET_RESEARCH_VISIBLE.new(inner)
		
	if operand == "ACTIVATE_EVENT":
		return null
		
	if operand == "":
		return null
		
	return null
