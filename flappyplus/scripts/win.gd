extends CanvasLayer
@onready var score_label: Label = %Score
@export var auto_return_sec := 10.0

func _ready() -> void:
	if score_label:
		score_label.text = "Score: %d" % GameState.last_score
	if auto_return_sec > 0.0:
		await get_tree().create_timer(auto_return_sec).timeout
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _unhandled_input(e: InputEvent) -> void:
	if e.is_pressed():
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
