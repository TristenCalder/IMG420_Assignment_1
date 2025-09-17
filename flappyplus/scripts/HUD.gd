extends CanvasLayer

@onready var score_label:  Label = $ScoreLabel
@onready var shield_label: Label = $ShieldLabel

func _ready() -> void:
	if score_label:
		score_label.text = str(GameState.score)
		GameState.score_changed.connect(func(v: int) -> void:
			score_label.text = str(v)
		)

	if shield_label:
		_on_shield_changed(GameState.shield_time)
		GameState.shield_changed.connect(_on_shield_changed)

func _on_shield_changed(t: float) -> void:
	if not shield_label: return
	shield_label.text = "Shield: %.1fs" % t if t > 0.0 else ""
