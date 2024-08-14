extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func ToggleUI(toggle: bool):
	$".".visible = toggle
	pass
	

