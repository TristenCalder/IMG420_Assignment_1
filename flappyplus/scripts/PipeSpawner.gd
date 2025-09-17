extends Node

const PIPE_PAIR := preload("res://scenes/PipePair.tscn")
const SHIELD    := preload("res://scenes/ShieldPickup.tscn")

@export var spawn_interval: float = 1.2
@export var y_range: float = 200.0
@export var shield_chance: float = 0.40
@export var forced_every_n_pipes: int = 3

var _running := false
var _gen := 0
var _pipe_count := 0

func start() -> void:
	_running = true
	_gen += 1
	_spawn_loop(_gen)

func stop() -> void:
	_running = false

func reset() -> void:
	stop()
	await get_tree().process_frame
	start()

func _spawn_loop(gen: int) -> void:
	while _running and GameState.playing and gen == _gen:
		var pipe = PIPE_PAIR.instantiate()
		var view_size: Vector2 = get_viewport().get_visible_rect().size
		pipe.position = Vector2(
			view_size.x + 120.0,
			view_size.y * 0.5 + randf_range(-y_range, y_range)
		)
		get_tree().current_scene.add_child(pipe)

		_pipe_count += 1
		print("Spawned pipe #", _pipe_count, " at ", pipe.position)

		var force_spawn := forced_every_n_pipes > 0 and (_pipe_count % forced_every_n_pipes) == 0
		if force_spawn or randf() < shield_chance:
			var s := SHIELD.instantiate()
			var y_min: float = 120.0
			var y_max: float = view_size.y - 220.0
			s.position = Vector2(
				pipe.position.x + 140.0,
				clamp(randf_range(y_min, y_max), y_min, y_max)
			)
			if "speed" in s:
				s.speed = -220.0
			get_tree().current_scene.add_child(s)
			print(">>> Spawned SHIELD at ", s.position, " after pipe #", _pipe_count)

		await get_tree().create_timer(spawn_interval).timeout
