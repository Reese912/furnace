extends Node3D

@export var damage := 1.0

@onready var anim = $anim
@onready var raycast = $RayCast3D
@onready var sfx_shot_sound = $sfx_shot_sound

var can_shoot = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_shoot and not anim.is_playing():
		anim.play("shoot")
		sfx_shot_sound.play()
		can_shoot = false

		#if raycast.is_colliding():
			#var collider = raycast.get_collider()
#
			#if collider.is_in_group("enemy"):
				#collider.hp -= damage
				
		if raycast.is_colliding():
			raycast.force_raycast_update()
			var collider = raycast.get_collider()

			var target = collider

			# Walk up the tree until we find the enemy
			while target and not target.is_in_group("enemy"):
				target = target.get_parent()

			if target and target.has_method("hit_by_player"):
				target.hit_by_player(damage)			
				
	
	if Input.is_action_pressed("inspect") and not anim.is_playing():
		anim.play("inspect")
		if Input.is_action_pressed("shoot"):
			anim.stop("inspect")
				


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shoot":
		can_shoot = true
	elif anim_name == "equip":
		can_shoot = true
	elif anim_name == "unequip":
		can_shoot = false
		visible = false
		
