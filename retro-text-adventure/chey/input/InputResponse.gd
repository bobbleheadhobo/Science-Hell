extends VBoxContainer


func set_text(input: String, response: String):
	# concante both strings
	$InputHistory.text = " > " + input
	# changes setting text property on Response label 
	$Response.text = response
