class_name CondExpr extends RefCounted

const operators = [
	"NOT", "AND", "OR", "GT", "GTE", "LT", "LTE", "EQ", "NE",
	"HAS_RESEARCH", "HAS_EVENT", "RESOURCE", "INT", "FLOAT"
]

const ops_pattern = "([A-Z_]+)\\((.*)\\)"
const arg_pattern = "(\\w+\\((?:[^()]|(?R))*\\)),(\\w+\\((?:[^()]|(?R))*\\))"
static var match_operation : RegEx
static var match_arguments : RegEx


func _init():
	var err : Error
	match_operation = RegEx.new()
	match_arguments = RegEx.new()
	
	err = match_operation.compile(ops_pattern)
	if err != OK:
		push_error("Invalid regex pattern for CondExpr: operations")
		
	err = match_arguments.compile(arg_pattern)
	if err != OK:
		push_error("Invalid regex pattern for CondExpr: arguments")


func has_research(expr : String) -> bool:
	# to be implemented
	return true
	
func has_event(expr : String) -> bool:
	# to be implemented
	return true
	
func get_resource(expr : String) -> float:
	# to be implemented
	return 10.5


func parse_expr(expr : String) -> String:
	var result : RegExMatch = match_operation.search(expr)
	var operand : String = result.get_string(1)
	var inner : String = result.get_string(2)
	
	if operand.is_empty() or inner.is_empty() or not operators.has(operand):
		return ""
		
	# Single argument
	if operand == "NOT":
		return "not (%s)" % parse_expr(inner)
		
	elif operand == "HAS_RESEARCH":
		return "has_research(%s)" % result.get_string(2)
		
	elif operand == "HAS_EVENT":
		return "has_event(%s)" % result.get_string(2)
		
	elif operand == "RESOURCE":
		return "get_resource(%s)" % result.get_string(2)
		
	elif operand == "INT":
		return "(%s)" % result.get_string(2)
		
	elif operand == "FLOAT":
		return "(%s)" % result.get_string(2)
	
	# Look for two arguments separated by a comma
	result = match_arguments.search(inner)
	var arg1 : String = result.get_string(1)
	var arg2 : String = result.get_string(2)
	
	if arg1.is_empty() or arg2.is_empty():
		return ""
	
	# Double arguments
	if operand == "AND":
		return "(%s and %s)" % [parse_expr(arg1), parse_expr(arg2)]
	
	elif operand == "OR":
		return "(%s or %s)" % [parse_expr(arg1), parse_expr(arg2)]
		
	elif operand == "GT":
		return "(%s > %s)" % [parse_expr(arg1), parse_expr(arg2)]
		
	elif operand == "GTE":
		return "(%s >= %s)" % [parse_expr(arg1), parse_expr(arg2)]
		
	elif operand == "LT":
		return "(%s < %s)" % [parse_expr(arg1), parse_expr(arg2)]
	
	elif operand == "LTE":
		return "(%s <= %s)" % [parse_expr(arg1), parse_expr(arg2)]

	elif operand == "EQ":
		return "(%s == %s)" % [parse_expr(arg1), parse_expr(arg2)]
	
	elif operand == "NE":
		return "(%s != %s)" % [parse_expr(arg1), parse_expr(arg2)]
		
	return ""
	
	
func execute(expr : String) -> void:
	var gd_expr = Expression.new()
	var parsed = parse_expr(expr)
	gd_expr.parse(parsed)
	print(parsed)
	print("evaluates to: %s" % gd_expr.execute([], self))
