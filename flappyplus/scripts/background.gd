extends ParallaxBackground

@export var scroll_speed_px: float = 220.0

@onready var sky_layer: ParallaxLayer     = $SkyLayer
@onready var ground_layer: ParallaxLayer  = $GroundLayer
@onready var sky_sprite: Sprite2D         = $SkyLayer/Sky
@onready var ground_tiles: Node2D         = ($GroundLayer.get_node_or_null("Tiles") as Node2D)

func _ready() -> void:
	if ground_tiles == null:
		ground_tiles = Node2D.new()
		ground_tiles.name = "Tiles"
		ground_layer.add_child(ground_tiles)

	sky_layer.motion_scale.x    = 0.10
	ground_layer.motion_scale.x = 1.00

	if sky_sprite:
		sky_sprite.centered = false
		sky_sprite.position = Vector2.ZERO

	_make_tiles()

func _process(delta: float) -> void:
	scroll_offset.x += scroll_speed_px * delta

func _make_tiles() -> void:
	var view := get_viewport().get_visible_rect().size

	var ground_tex := load("res://assets/gfx/base.png") as Texture2D
	if ground_tex:
		var gw := ground_tex.get_width()
		var gh := ground_tex.get_height()
		var ground_needed := int(ceil(view.x / gw)) + 1

		for c in ground_tiles.get_children():
			c.queue_free()

		for i in range(ground_needed):
			var s := Sprite2D.new()
			s.texture = ground_tex
			s.centered = false
			s.position = Vector2(i * gw, view.y - gh)
			ground_tiles.add_child(s)

		ground_layer.motion_mirroring.x = float(gw * ground_needed)

		if sky_sprite and sky_sprite.texture:
			var sw := sky_sprite.texture.get_width()
			var sh := sky_sprite.texture.get_height()
			var sky_needed := int(ceil(view.x / sw)) + 1

			sky_sprite.position = Vector2(0, view.y - gh - sh)

			for n in sky_layer.get_children():
				if n != sky_sprite and n is Sprite2D and n.name.begins_with("SkyClone"):
					n.queue_free()

			for i in range(1, sky_needed):
				var clone := Sprite2D.new()
				clone.name = "SkyClone%d" % i
				clone.texture = sky_sprite.texture
				clone.centered = false
				clone.position = sky_sprite.position + Vector2(i * sw, 0)
				sky_layer.add_child(clone)

			sky_layer.motion_mirroring.x = float(sw)
