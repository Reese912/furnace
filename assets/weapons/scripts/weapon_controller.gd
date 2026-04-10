class_name Weapon_Controller extends Node

#
@export var current_weapon: Weapon
@export var weapon_model_parent: Node3D

var current_weapon_model: Node3D

#start of the game spawns weapon
func _ready() -> void:
	if current_weapon:
		spawn_weapon_model()

#weapon spawn function
func spawn_weapon_model():
	if current_weapon_model:
		current_weapon_model.queue_free() #check if we have a weapon and get rid of it if we do
		
	if current_weapon:
		current_weapon_model = current_weapon.weapon_model.instantiate() #makes a scene with our weapon
		weapon_model_parent.add_child(current_weapon_model) #add th0.2at scene into the camera 3d node
		current_weapon_model.position = current_weapon.weapon_position


	
