extends Node2D
@export var speed := -220.0

@onready var gate: Area2D = $ScoreGate

func _ready():
	gate.monitoring = true
	gate.monitorable = true
	gate.body_entered.connect(_on_gate_body_entered)

	var cs: CollisionShape2D = gate.get_node("CollisionShape2D")
	if cs.shape == null:
		cs.shape = RectangleShape2D.new()
	(cs.shape as RectangleShape2D).size = Vector2(60, 300)
	cs.disabled = false

func _physics_process(delta):
	position.x += speed * delta
	if position.x < -300:
		queue_free()

func _on_gate_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Bird":
		GameState.add_point(1)
		gate.queue_free()
