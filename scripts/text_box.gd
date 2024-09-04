extends Control
class_name TextBox

@export var animator : AnimationPlayer
@export var tut_arrow : Sprite2D
@onready var panel_container = $PanelContainer
@onready var text = $PanelContainer/MarginContainer/Text
@onready var button = $PanelContainer/MarginContainer2/Button
@onready var text_arrow = $PanelContainer/MarginContainer/Arrow

var text_index := 0

var dialogue_options = [
	"I was pretty good I think...", "Please let me through! My wife is on the other side.", "You're pretty cute aha", "AHHHHHHHHHHHHHHHHHHHHHHHHHHHHH", "Wait... you're not the real Anubis!",
	"Can we hurry this along?",
	"Don’t forget about the time I could’ve stolen that necklace but then didn’t!",
	"You can’t see [i]everything[/i] we did…right?",
	"Oh what, was Anubis too busy to judge me himself?",
	"Is there a bathroom in here?",
	"Please, Ammit would hate the way I taste I’m sure",
	"You’re telling me my whole life fits on this one scroll?",
	"Ahnk ahnk my uber is here",
	"Am I really being judged for eternity by the new guy?",
	"You can just send me on up, I’m a good guy, you can trust me",
	"Well let’s see your scroll if you think you’re so high and mighty eh?",
	"I really did try my best, that counts for something right?",
	"How much for you to tip the scales in my favor huh?",
	"Ra Ra, ooh la la",
	"Please, I’ll do anything, just don’t send me to Ammit. Anything but that!!",
	"No, no. I can’t be here. I was supposed to get married next week",
	"But what about my kids, who will look after them? Send me back please!!",
	"But, I was so young…",
	"You’re gonna want to send me on through. Trust me, I know the Pharaoh.",
	"Not Ammit, I beg of you! Just send me up, no one has to know!",
	"If you let me on through I’ll make it worth your while...",
	"It all happened so fast, I never even saw it coming…",
	"Any chance you could just let this one slide",
]
var tutorial_text = [
	["Alright intern, Anubis has a plane to catch. Let's make this quick."], 
	["You'll be weighing these newly deceased souls against a feather, yada yada yada.", "enter_scale"], 
	["You know the deal."], 
	["They'll come in with the riches they were buried with, which will help their case.", "enter_money"],
	["They're gonna have a scroll on them determining the most significant actions of their lives.", "enter_scroll"], 
	["You will need to adjust the scale according to their deeds.", "scroll_trigger"], 
	["Unfortunately, our translator is on maternity leave, so you'll have to use this book.", "enter_book"],
	["For every good deed, they get to add a Scarab Weight™️ to the feather side of our Holy Scale.", "enter_weight_right"],
	["Give it a shot. (Drag the weight onto the right scale)", "disable_button"],
	["For every bad deed, they get to add a Scarab Weight™️ to the soul side of our Holy Scale.", "enter_weight_left"],
	["Give it a shot. (Drag the weight onto the left scale)", "disable_button"],
	["If you judge that their soul outweighs the feather after their actions are accounted for, they get sent straight to Ammit.", "enter_ammit"],
	["He forgot his lunch today, so he's extra hungry."],
	["Alternatively, if one's soul yet weighs less than a feather, they may ascend to a heavenly existence.", "enter_heaven"],
	["That's about it. Alright, gotta run. Anubis out!", "prepare_for_start"],
	["", "end_tutorial"]
]
# Called when the node enters the scene tree for the first time.
func _ready():
	ScaleManager.tutorial_weight_dragged.connect(_on_scale_manager_tutorial_weight_dragged)
	text.text = tutorial_text[0][0]
	#generate_random_text()
	
func generate_random_text():
	text.text = dialogue_options[randi_range(0, dialogue_options.size()-1)]

func next_text_slide():
	text_index += 1
	if tutorial_text[text_index].size() > 1:
		text.text = tutorial_text[text_index][0]
		animator.play(tutorial_text[text_index][1])
	else:
		text.text = tutorial_text[text_index][0]

func button_off():
	text_arrow.visible = false
	button.disabled = true

func reset_to_default():
	text_arrow.visible = true
	button.disabled = false

func _on_button_pressed():
	#check if condition is met (weight examples)
	next_text_slide()

func _on_scale_manager_tutorial_weight_dragged():
	reset_to_default()
	tut_arrow.visible = false

func make_tutorial_weight_interactable():
	ScaleManager.make_tutorial_weight_interactable(true)
