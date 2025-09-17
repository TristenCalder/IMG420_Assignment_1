extends CanvasLayer

func _ready() -> void:
	%Start.pressed.connect(_start)
	if has_node("%HowTo"):
		%HowTo.pressed.connect(_howto)
	%Quit.pressed.connect(_quit)

func _start() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _howto() -> void:
	OS.alert("Flap: Space/LMB\nDash: Shift\nDive: S/Down\nAvoid pipes. Get points.")

func _quit() -> void:
	get_tree().quit()
