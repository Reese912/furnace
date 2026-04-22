extends CharacterBody3D

var player = null
const SPEED = 10.0
var gravity = 9.8
const enemy_damage = 1
var hp = 500 

#var status = true #true = alive ; false = dead

@export var player_path : NodePath
@onready var nav_agent = $NavigationAgent3D

func _ready() -> void:
	player = get_node(player_path)
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	if player == null:
		return

	# IMPORTANT: update target every frame
	nav_agent.set_target_position(player.global_position)

	# gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	var next_location = nav_agent.get_next_path_position()
	var current_location = global_transform.origin

	var new_velocity = (next_location - current_location).normalized() * SPEED

	velocity = velocity.move_toward(new_velocity, 0.25)

	move_and_slide()

func hit_by_player(damage):
	hp -= damage
	print("ENEMY HP:",hp)
	$sfx_enemy_hit.play()
	if hp <= 0:
		var death_sound = $sfx_death
		remove_child(death_sound)
		get_tree().current_scene.add_child(death_sound)

		death_sound.play()
		queue_free()

		#queue_free() ##deletes enemy upon death
		#$sfx_death.play() #only play the death sound once
