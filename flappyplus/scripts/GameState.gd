extends Node

signal score_changed(v: int)
signal shield_changed(t: float)
signal game_over
signal game_won

@export var win_score: int = 20

var last_score: int = 0
var score: int = 0
var playing: bool = false
var shield_time: float = 0.0

func new_game() -> void:
	score = 0
	playing = true
	shield_time = 0.0
	emit_signal("score_changed", score)
	emit_signal("shield_changed", shield_time)

func add_point(v: int = 1) -> void:
	if not playing: return
	score += v
	emit_signal("score_changed", score)
	_check_win()

func _check_win() -> void:
	if playing and score >= win_score:
		playing = false
		last_score = score
		emit_signal("game_won")

func add_shield(seconds: float) -> void:
	shield_time = max(shield_time, seconds)
	emit_signal("shield_changed", shield_time)

func clear_shield() -> void:
	shield_time = 0.0
	emit_signal("shield_changed", shield_time)

func _process(delta: float) -> void:
	if shield_time > 0.0:
		shield_time = max(shield_time - delta, 0.0)
		emit_signal("shield_changed", shield_time)

func lose() -> void:
	if not playing: return
	playing = false
	last_score = score
	emit_signal("game_over")
