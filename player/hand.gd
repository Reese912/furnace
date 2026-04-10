extends Node3D


var weapons = []
var selected_weapon = 0 

func _ready() -> void:
	for w in self.get_children():
		weapons.append(w)
		w.visible = false
		w.anim.play("unequip")
	weapons[selected_weapon].visible = true
	weapons[selected_weapon].anim.play = 'equip'
