extends Node2D

@onready var visual = $Visual
@export var animator : AnimationPlayer
@export var button : Button
var char_index := 0
var char_sprites = [["res://assets/IMG_1498.PNG", "res://assets/IMG_1497.PNG"], ["res://assets/IMG_1496.PNG", "res://assets/IMG_1495.PNG"], ["res://assets/IMG_1494.PNG", "res://assets/IMG_1493.PNG"], ["res://assets/IMG_1489.PNG", "res://assets/IMG_1492.PNG"]]

func _ready():
	pick_rand_character()
	character_enter(char_index)

func pick_rand_character():
	char_index = randi_range(0,char_sprites.size()-1)
	visual.texture = load(char_sprites[char_index][0])

func character_enter(character):
	print(str(character) + " has entered")
	
	animator.play("character_enter")

func switch_char_sprite():
	visual.texture = load(char_sprites[char_index][1])

func _on_button_pressed():
	print("pressed")
	animator.play("scroll_trigger")

func _on_button_mouse_entered():
	pass
	#button.scale += Vector2(1.1, 1.1) effect here
