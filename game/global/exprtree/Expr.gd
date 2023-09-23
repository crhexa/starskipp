class_name Expr extends RefCounted

var arg1

func _init(a : Expr = null):
	arg1 = a
	
# Overridden by other classes
func evaluate() -> Variant:
	return


class TRUE extends Expr:
	func evaluate() -> Variant:
		return true
		
		
class NOT extends Expr:
	func evaluate() -> Variant:
		return not (arg1 as bool)


# Base class for terminals
class INT extends Expr:
	func _init(a : int):
		arg1 = a
		
	func evaluate() -> Variant:
		return arg1
		
		
class FLOAT extends INT:
	func _init(a : float):
		arg1 = a
		
	
# Base class for query terminals
class HAS_EVENT extends INT:
	func _init(a : String):
		arg1 = a
		
	func evaluate() -> Variant:
		return false


class HAS_RESEARCH extends HAS_EVENT:
	func evaluate()	-> Variant:
		return ResearchPool.lookup(arg1).is_complete()
		
		
class HAS_PLAYER_FLAG extends HAS_EVENT:
	func evaluate() -> Variant:
		return false
		
		
class HAS_SYSTEM_FLAG extends HAS_EVENT:
	func evaluate() -> Variant:
		return false
		
		
class HAS_PLANET_FLAG extends HAS_EVENT:
	func evaluate() -> Variant:
		return false
		

class GET_SYSTEM_RESOURCE extends HAS_EVENT:
	func evaluate() -> Variant:
		var id = SystemResources.Type[arg1]["id"]
		return GlobalResources.system.storage[id]
		
		
# Base class for 2 argument expressions
class AND extends Expr:
	var arg2
	
	func _init(a : Expr, b : Expr):
		arg1 = a
		arg2 = b
	
	func evaluate() -> Variant:
		return arg1.evaluate() and arg2.evaluate()


class OR extends AND:
	func evaluate() -> Variant:
		return arg1.evaluate() or arg2.evaluate()
	
	
class GT extends AND:
	func evaluate() -> Variant:
		return arg1.evaluate() > arg2.evaluate()
		
		
class GTE extends AND:
	func evaluate() -> Variant:
		return arg1.evaluate() >= arg2.evaluate()
		

class LT extends AND:
	func evaluate() -> Variant:
		return arg1.evaluate() < arg2.evaluate()
		

class LTE extends AND:
	func evaluate() -> Variant:
		return arg1.evaluate() <= arg2.evaluate()
		
		
class EQ extends AND:
	func evaluate() -> Variant:
		return arg1.evaluate() == arg2.evaluate()
		
		
class NE extends AND:
	func evaluate() -> Variant:
		return arg1.evaluate() != arg2.evaluate()
