extends CharacterBody2D

@export var gravity: float        = 1400.0
@export var flap_strength: float  = -420.0
@export var dash_impulse: Vector2 = Vector2(260, 0)
@export var dive_force: float     = 1000.0
@export var max_fall: float       = 900.0

@onready var gfx: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	motion_mode   = CharacterBody2D.MOTION_MODE_FLOATING
	collision_layer = 1
	collision_mask  = 1 << 1
	set_safe_margin(4.0)

	if gfx:
		gfx.animation = "Flap"
		gfx.stop()
		gfx.frame = 1
		gfx.speed_scale = 1.0
		gfx.animation_finished.connect(_on_gfx_finished)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if Input.is_action_just_pressed("flap"):
		velocity.y = flap_strength
		_play_flap_once()

	if Input.is_action_just_pressed("dash"):
		velocity += dash_impulse

	if Input.is_action_pressed("dive"):
		velocity.y = min(velocity.y + dive_force * delta, max_fall)

	move_and_slide()

	rotation = clamp(lerp(rotation, deg_to_rad(velocity.y * 0.05), 0.2),
		deg_to_rad(-30), deg_to_rad(60))

	var hit_pipe := false
	for i in range(get_slide_collision_count()):
		var c := get_slide_collision(i)
		if c and c.get_collider():
			if str(c.get_collider().name).begins_with("Pipe"):
				hit_pipe = true
				break

	if hit_pipe:
		if "shield_time" in GameState and GameState.shield_time > 0.0:
			if "use_shield" in GameState:
				GameState.use_shield()
			velocity = Vector2(-280, -240)
			await _blink_brief()
		else:
			if "lose" in GameState:
				GameState.lose()


func _play_flap_once() -> void:
	if not gfx: return
	gfx.animation = "Flap"
	gfx.frame = 0
	gfx.play()

func _on_gfx_finished() -> void:
	if gfx.animation == "Flap":
		gfx.stop()
		gfx.frame = 1

func _blink_brief() -> void:
	var tw := create_tween()
	tw.tween_property(self, "modulate:a", 0.25, 0.08).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "modulate:a", 1.0, 0.08)
	await tw.finished
