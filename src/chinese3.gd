extends Chinese

func _ready() -> void:
	setCaptureTime(0.1)
	animation = "idle"
	play()
	$hazard.setWaitTime(reactionSpeed)
	hazard = $hazard
	chopstickArea = $chopstick
