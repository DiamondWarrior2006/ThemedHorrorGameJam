extends Area2D

@export var sceneTo : String

var can_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(str(can_open))
	if can_open == true:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file(sceneTo)


func _on_body_entered(body):
	if body.name == "Misha":
		can_open = true


func _on_body_exited(body):
	if body.name == "Misha":
		can_open = false
