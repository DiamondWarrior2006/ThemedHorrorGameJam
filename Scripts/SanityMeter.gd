extends Node

var MAX_METER = 100

var meterThresholds = [25,50,75]
var meterFillPercent

signal meterDepleted(objectSource)
signal meterChanged(oldAmount, newAmount)
signal doThreshold

# Called when the node enters the scene tree for the first time.
func _ready():
	meterFillPercent = MAX_METER
	pass # Replace with function body.
	
func IncreaseMeter(amount):
	meterChanged.emit(meterFillPercent, meterFillPercent+amount)
	meterFillPercent += amount
	
	CheckThreshold()
	
	if(meterFillPercent>=100):
		meterFillPercent =100
	

func DecreaseMeter(amount):
	meterChanged.emit(meterFillPercent, meterFillPercent-amount)
	meterFillPercent -= amount
	
	CheckThreshold()
	
	if(meterFillPercent<=0):
		meterDepleted.emit(self)

func CheckThreshold():
	for threshold in meterThresholds:
		if(meterFillPercent<= threshold):
			doThreshold.emit(threshold.get_index())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$".".value = meterFillPercent
	pass
