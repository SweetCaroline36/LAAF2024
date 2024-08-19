extends Control

@onready var panel_container = $PanelContainer
@onready var text = $PanelContainer/MarginContainer/Text

var text_index := 0

var dialogue_options = ["I was pretty good I think...", "Please let me through! My wife is on the other side.", "You're pretty cute aha", "AHHHHHHHHHHHHHHHHHHHHHHHHHHHHH", "Wait... you're not the real Anubis!"]
var tutorial_text = [
	["Alright intern, Anubis has a plane to catch. Let's make this quick."], 
	["You'll be weighing these newly deceased souls against a feather, yada yada yada.", "enter_scale"], 
	["You know the deal."], 
	["They're gonna have a scroll on them determining the most significant actions of their lives.", "enter_scroll"], 
	["Unfortunately, our translator is on maternity leave, so you'll have to use this book.", "enter_book"],
	["For every good deed, they get to add a Scarab Weight™️ to the feather side of our Holy Scale", "enter_weight_right"],
	["For every bad deed, they get to add a Scarab Weight™️ to the soul side of our Holy Scale", "enter_weight_left"],
	["If you judge that their soul outweighs the feather after their actions are accounted for, they get sent straight to Ammit.", "enter_ammit"],
	["He forgot his lunch today, so he's extra hungry."],
	["Otherwise, they may ascend to a heavenly existence", "enter_heaven"],
	["That's about it. Alright, gotta run. Anubis out!"]
]
# Called when the node enters the scene tree for the first time.
func _ready():
	text.text = tutorial_text[0][0]
	#generate_random_text()
	
func generate_random_text():
	text.text = dialogue_options[randi_range(0, dialogue_options.size()-1)]

func next_text_slide():
	text_index += 1
	if tutorial_text[text_index].size() > 1:
		text.text = tutorial_text[text_index][0]
		#animation tutorial_text[text_index][1]
	else:
		text.text = tutorial_text[text_index]
