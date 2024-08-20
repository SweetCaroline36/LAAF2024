extends Node2D
class_name Scroll

@export var animator : AnimationPlayer
@export var text_box : RichTextLabel

var scroll_text = "3J"
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	text_box.text = scroll_text

func play_scroll_anim():
	animator.play("open_scroll")
	
func reset_scroll_anim():
	animator.play("RESET")

func change_scroll_text(text:String):
	text_box.text = text
