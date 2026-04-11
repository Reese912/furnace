extends Node

var debug_mode := false

@onready var root = get_tree().current_scene
@export var checker_texture: Texture2D = preload("res://assets/textures/icon.svg")

func _process(delta):
	if Input.is_action_just_pressed("debug"):
		toggle_debug()

func toggle_debug():
	debug_mode = !debug_mode
	
	apply_to_nodes(root)

func apply_to_nodes(node):	if node is MeshInstance3D:
		if debug_mode:
			var mat = StandardMaterial3D.new()
			mat.albedo_texture = checker_texture
			node.material_override = mat
		else:
			node.material_override = null
	
	for child in node.get_children():
		apply_to_nodes(child)
