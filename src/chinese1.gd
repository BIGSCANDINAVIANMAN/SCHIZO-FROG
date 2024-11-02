extends Chinese

func _ready() -> void:
	setCaptureTime(0.4)
	animation = "idle"
	play()
	$hazard.setWaitTime(reactionSpeed)
