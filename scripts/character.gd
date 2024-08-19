extends Node2D
class_name Character

@onready var visual = $Visual
@export var animator : AnimationPlayer
@export var button : Button
var char_index := 0
var anubis_sprites = ["res://assets/Anubis1.PNG", "res://assets/Anubis2.PNG"]
var char_sprites = [["res://assets/IMG_1498.PNG", "res://assets/IMG_1497.PNG"], ["res://assets/IMG_1496.PNG", "res://assets/IMG_1495.PNG"], ["res://assets/IMG_1494.PNG", "res://assets/IMG_1493.PNG"], ["res://assets/IMG_1489.PNG", "res://assets/IMG_1492.PNG"]]

func _ready():
	visual.texture = load(anubis_sprites[0])
	character_enter()

func pick_rand_character():
	char_index = randi_range(0,char_sprites.size()-1)
	visual.texture = load(char_sprites[char_index][0])

func character_enter():
	animator.play("character_enter")

func switch_char_sprite():
	if not GameManager.is_tutorial:
		visual.texture = load(char_sprites[char_index][1])

func switch_anubis_sprite(i:int):
	visual.texture = load(anubis_sprites[i])

func _on_button_pressed():
	print("pressed")
	animator.play("scroll_trigger")

	#button.scale += Vector2(1.1, 1.1) effect here
