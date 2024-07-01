extends Area2D

@export var player = CharacterBody2D
@export var sign = Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Charlos":
		var pcam = body.pcam
		pcam.set_follow_target(sign)
		pcam.set_zoom(Vector2(2, 2))


func _on_body_exited(body):
	if body.name == "Charlos":
		var pcam = body.pcam
		pcam.set_follow_target(player)
		pcam.set_zoom(Vector2(1, 1))
