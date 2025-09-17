extends CanvasLayer


@onready var score_label: Label = %Score
@export var auto_return_sec: float = 60.0

func _ready() -> void:
	if score_label:
		score_label.text = "Score: %d" % GameState.last_score
	else:
		push_error("GameOver.gd: couldn't find %Score label")

	if auto_return_sec > 0.0:
		_auto_return()

func _unhandled_input(e: InputEvent) -> void:
	if e.is_pressed():
		_to_menu()

func _auto_return() -> void:
	await get_tree().create_timer(auto_return_sec).timeout
	_to_menu()

func _to_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
