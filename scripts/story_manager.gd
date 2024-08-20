extends Node2D
class_name StoryManager

@export var nom_sound:AudioStreamPlayer2D
@export var animator : AnimationPlayer
@export var character : Character
@export var said_text : TextBox
@export var scroll : Scroll
var test_index := 0
var current_day := 0		#true = heaven, scroll symbols
var easy_scroll_meanings = [
	["a'\n",true], ["JI\n",true], [",!\n",false], ["J3\n",false], ["tz'\n",true], ["Z3\n",false], ["Z'\n",false], ["J'\n",false], ["^'\n",true]
]
var intermediate_scroll_meanings = [ #decree
	["U'\n",true], ["a'\n",false], ["^;tz_J3\n",false], 
	["!'\n",false], ["/]\n",false], ["t;,!\n",true], 
	["/`JI\n",true], ["tz`ZIk\n",false], ["Wd\n",false],
	["/`ZI\n",true], ["i`JI\n",true], ["tz;!k\n",false],
	["^`JI\n",true], ["tz_J3\n",true], ["^`IJ3\n",false], #qustionable (stole from enemy to give to child)
	["x`\n",false], ["tz`ZI\n",true], [",i!\n",false],  #qustionable (killed enemy soldier)
]

func _ready():
	pass
	#generate_random_scroll(3)

func begin_day(count:int):
	if count == 1:
		GameManager.change_state(GameManager.GameState.DAYONE)
	animator.play("reset_world")
	#new_person()

func new_person():
	character.pick_rand_character()
	generate_random_scroll(3)
	said_text.generate_random_text()
	character.character_enter()
	ScaleManager.generate_weights(1, Vector2(608, 320))

func generate_random_scroll(amount:int):
	#var items = intermediate_scroll_meanings.duplicate()
	#items.shuffle()
	#var scroll_str = "[center]"
	#for n in amount:
	#	scroll_str += str(items.pop_back()[0])
	#	scroll_str += "\n"
	#print(scroll_str)
	#scroll.change_scroll_text(scroll_str)
	var new_str = intermediate_scroll_meanings[test_index][0] + intermediate_scroll_meanings[test_index+1][0]
	scroll.change_scroll_text(new_str)
	test_index += 2

func _on_skip_button_pressed():
	begin_day(1)
	
func reset_world():
	animator.play("reset_world")
	
func _on_heaven_pressed():
	animator.play("send_to_heaven")

func _on_ammit_pressed():
	animator.play("send_to_ammit")
