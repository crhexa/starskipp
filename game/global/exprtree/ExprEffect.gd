class_name ExprEffect

var arg1

func _init(a : String):
	arg1 = a
	
func execute():
	return


class SET_RESEARCH_HIDDEN extends ExprEffect:
	func execute():
		var obj : ResearchObject = ResearchPool.lookup(arg1)
		if obj != null:
			obj.hidden = true


class SET_RESEARCH_VISIBLE extends ExprEffect:
	func execute():
		var obj : ResearchObject = ResearchPool.lookup(arg1)
		if obj != null:
			obj.hidden = false





