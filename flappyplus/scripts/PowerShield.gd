extends Area2D

@export var speed: float   = -220.0
@export var seconds: float = 3.0

func _ready() -> void:
	z_index = 50
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x < -120.0:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D and body.name == "Bird":
		GameState.add_shield(seconds)
		print(">>> SHIELD PICKED at ", position, " for ", seconds, "s")
		queue_free()
