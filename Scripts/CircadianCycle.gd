extends Node

const LENGTH_OF_DAY = 300
const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REALTIME =(2*PI)/MINUTES_PER_DAY

signal time_tick(day:int,hour:int,minute:int)

var time : float = 0.0 
var past_minute: float = -1.0

#1D LUT that defines our color palette 
@export var gradient:GradientTexture1D
# 1 RealTime second = INGAME_MULTIPLIER minutes
@export var INGAME_MULTIPLIER : float = 1.0

func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float )->void:
	time+=delta
	var value = (sin(time-PI/2)+1.0)/(2.0*INGAME_MULTIPLIER)
	RenderingServer.set_default_clear_color(gradient.gradient.sample(value))
	
	_recalc_time()

func _recalc_time()-> void:
	var total_minutes = int(time/INGAME_TO_REALTIME) 
	
	var day = int(total_minutes/MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes/MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	time_tick.emit(day,hour,minute)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
	
	
	pass
