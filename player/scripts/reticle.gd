extends CenterContainer

@export var dot_radius = 1.0
@export var dot_color = Color.GREEN

func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2(0,0),dot_radius,dot_color)
