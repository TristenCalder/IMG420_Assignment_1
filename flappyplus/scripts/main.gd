extends Node2D

@onready var spawner: Node       = $PipeSpawner
@onready var pause_menu: CanvasLayer = $PauseMenu
@onready var bird: CharacterBody2D   = $Bird
var _wired := false

func _ready() -> void:
	get_tree().paused = false
	GameState.new_game()

	if not has_node("HUD"):
		add_child(preload("res://scenes/HUD.tscn").instantiate())

	if not _wired:
		pause_menu.restart_requested.connect(_reset)
		GameState.game_over.connect(_on_game_over)
		GameState.game_won.connect(_on_game_won)
		_wired = true

	spawner.start()

func _unhandled_input(e: InputEvent) -> void:
	if e.is_action_pressed("pause"):
		if get_tree().paused: pause_menu.close()
		else:                 pause_menu.open()

func _reset() -> void:
	get_tree().paused = false


	for n in get_tree().current_scene.get_children():
		if n.name.begins_with("PipePair") or n.name.begins_with("ScoreGate"):
			n.queue_free()

	bird.position = Vector2(120, get_viewport_rect().size.y * 0.5)
	bird.velocity = Vector2.ZERO

	GameState.new_game()
	spawner.reset()

func _on_game_over() -> void:
	spawner.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
	
func _on_game_won() -> void:
	spawner.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Win.tscn")
