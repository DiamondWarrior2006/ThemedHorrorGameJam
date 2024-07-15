extends Area2D

var player_in_area = false
var is_talking = false

func _process(delta):
	if player_in_area == true:
		if Input.is_action_just_pressed("interact"):
			if Dialogic.current_timeline == null && is_talking == false:
				Dialogic.start("Test")
				is_talking = true

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
		is_talking = false
