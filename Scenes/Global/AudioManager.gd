extends AudioStreamPlayer


const music = preload("res://Sounds/Music/Forest.wav")

func _playMusic(music: AudioStream, volume = -10.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func playLevelMusic():
	_playMusic(music)

func changeBackground(bgColor: Color):
	RenderingServer.set_default_clear_color(bgColor)
	pass

func timeSlow(slowAmount: float):
	Engine.time_scale = slowAmount
	pass


