extends Control

@export var left_text_box:RichTextLabel
@export var left_trans_box:RichTextLabel
@export var right_text_box:RichTextLabel
@export var right_trans_box:RichTextLabel
@export var left_button:Button
@export var right_button:Button
@export var page_turn_sound:AudioStreamPlayer2D

var current_left_page = 0

var page_data := [
	"!3JI^a",
	"Death\nTheft\nFood\nGiving\nChild\nRa",
	"'z\ntzZ,%",#address citizen
	"Love\nPerson\nPharaoh\nMoney\nSoldier\nCitizen",
	"T(e;`\nd",
	"Praise\nSoul\nAnubis\nFor\nTo\nDid",
	"k_W]/x", #cant backslash
	"Negation\nFrom\nAdultered\nArson\nTemple\nAlcohol",
	"5i\ny\nK\nU",
	"Lied\nEnemy\nAlly\nWork\nSpouse"
	]
# Called when the node enters the scene tree for the first time.
func _ready():
	if page_data.size()%4:
		page_data.append("")
		page_data.append("")
	if not current_left_page:
		left_button.visible = false
	left_text_box.text = page_data[0]
	left_trans_box.text = page_data[1]
	right_text_box.text = page_data[2]
	right_trans_box.text = page_data[3]

func _on_last_page_pressed():
	page_turn_sound.play()
	current_left_page -= 4
	left_text_box.text = page_data[current_left_page]
	left_trans_box.text = page_data[current_left_page + 1]
	right_text_box.text = page_data[current_left_page + 2]
	right_trans_box.text = page_data[current_left_page + 3]
	right_button.visible = true
	if not current_left_page:
		left_button.visible = false

func _on_next_page_pressed():
	page_turn_sound.play()
	current_left_page += 4
	left_text_box.text = page_data[current_left_page]
	left_trans_box.text = page_data[current_left_page + 1]
	right_text_box.text = page_data[current_left_page + 2]
	right_trans_box.text = page_data[current_left_page + 3]
	left_button.visible = true
	if current_left_page + 4 >= page_data.size():
		right_button.visible = false
