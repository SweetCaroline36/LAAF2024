extends Node2D
class_name StoryManager

@export var animator : AnimationPlayer
@export var character : Character
@export var said_text : TextBox
@export var scroll : Scroll
var current_day := 0		#true = heaven, scroll symbols
var easy_scroll_meanings = [
	["a'",true], ["JI",true], [",!",false], ["J3",false]
	]
	
func begin_day(count:int):
	if count == 1:
		GameManager.change_state(GameManager.GameState.DAYONE)
	animator.play("reset_world")
	#new_person()

func new_person():
	character.pick_rand_character()
	scroll.change_scroll_text(easy_scroll_meanings[0][0])
	said_text.generate_random_text()
	
	character.character_enter()

func _on_skip_button_pressed():
	begin_day(1)
	
