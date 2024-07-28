extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.hide()
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == "Fade_In":
		on_transition_finished.emit()
		animation_player.play("Fade_Out")
	elif anim_name == "Fade_Out":
		color_rect.hide()

func transition():
	color_rect.show()
	animation_player.play("Fade_In")

func fade_out():
	color_rect.show()
	animation_player.play("Fade_Out")
