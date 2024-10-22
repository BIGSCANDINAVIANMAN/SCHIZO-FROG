extends Node

var activeAbilities = {
	"switchLeftRight": "left",
	"switchUpDown": "up",
	"sonic": "right",
	"antiSonic": false,
	"teleport": "down"
}

@onready var player = get_parent()
signal dashed

func _physics_process(_delta: float) -> void:
	if shouldActivate("switchLeftRight"):
		switchLeftRight()
	if shouldActivate("switchUpDown"):
		switchUpDown()
	if shouldActivate("sonic"):
		sonic(1000)
	if shouldActivate("antiSonic"):
		antiSonic(0.6)
	if shouldActivate("teleport"):
		teleport(300)
	
	for ability in activeAbilities:
		if shouldActivate(ability):
			startTimer(ability, 2)

# abilities dict formatted as {"abilityname": "input"}
# abilities not stated in dict set to false (inactive)
func setAbilities(abilities: Dictionary):
	for key in activeAbilities:
		activeAbilities[key] = false
	for key in abilities:
		activeAbilities[key] = abilities[key]

func shouldActivate(ability):
	return (activeAbilities[ability] 
	and Input.is_action_just_pressed(activeAbilities[ability])
	and cooldowns[ability])

func switchLeftRight():
	if isLeftRightSchizo:
		player.controls["left"] = "a"
		player.controls["right"] = "d"
	else:
		player.controls["left"] = "d"
		player.controls["right"] = "a"
	isLeftRightSchizo = !isLeftRightSchizo

func switchUpDown():
	if isUpDownSchizo:
		player.controls["up"] = "w"
		player.controls["down"] = "s"
	else:
		player.controls["up"] = "s"
		player.controls["down"] = "w"
	isUpDownSchizo = !isUpDownSchizo

func sonic(sonicVelocity):
	dashed.emit()
	player.velocity += sonicVelocity * player.getDirection()

func antiSonic(antiSonicFactor):
	var initialAccel = player.accel
	player.accel *= antiSonicFactor
	await get_tree().create_timer(1).timeout
	player.accel = initialAccel

# note how tf does this work can it teleport you into death or
func teleport(teleportRadius): 
	var angle = randi_range(0, 7) * PI / 4
	player.global_position += teleportRadius * Vector2(cos(angle), sin(angle))

# cooldown stuff this was supposed to be in a status class but um

var isLeftRightSchizo = false
var isUpDownSchizo = false
var cooldowns = {
	"switchLeftRight": true,
	"switchUpDown": true,
	"sonic": true,
	"antiSonic": true,
	"teleport": true
}

func startTimer(ability, cooldownTime):
	cooldowns[ability] = false
	await get_tree().create_timer(cooldownTime).timeout
	cooldowns[ability] = true
