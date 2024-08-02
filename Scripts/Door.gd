extends Area2D
#TODO trigger Scene swaps through global Game Manager

@export var sceneTo : PackedScene

var can_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if can_open == true:
		if Input.is_action_just_pressed("interact"):
			GameManager.swapScene(sceneTo)


func _on_body_entered(body):
	if body.name == "Misha":
		can_open = true


func _on_body_exited(body):
	if body.name == "Misha":
		can_open = false
