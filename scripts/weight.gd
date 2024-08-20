extends Area2D
class_name WeightObject

var weight:float = 0.5
var is_dragging := false
var is_hovering := false
var draggable := true
var offset:Vector2
var starting_pos:Vector2
var current_zone

signal selected(weight:WeightObject)
signal released()
signal cancelled()

func _process(_delta):
	if is_hovering or is_dragging:
		if Input.is_action_just_pressed("click") and not DragManager.is_weight_selected:
			scale = Vector2(1, 1)
			DragManager.is_dragging = true
			is_dragging = true
			DragManager.is_weight_selected = true
			starting_pos = global_position
			selected.emit(self)
			offset = get_global_mouse_position() - global_position
		if Input.is_action_pressed("click") and is_dragging: #drag obj
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			released.emit()
			DragManager.is_weight_selected = false
			DragManager.is_dragging = false
			is_dragging = false

func return_to_prev():
	global_position = starting_pos
	
func snap_to_site(site):
	global_position = site.global_position
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "position", site.global_position, 0.3).set_ease(Tween.EASE_OUT)
	
func _on_mouse_entered():
	if draggable and not DragManager.is_dragging:
		is_hovering = true
		if not DragManager.is_weight_selected:
			scale = Vector2(1.1, 1.1)
	else: is_hovering = false

func _on_mouse_exited():
	if not DragManager.is_dragging:
		is_hovering = false
		scale = Vector2(1, 1)
	
#func display_highlight(on:bool):
#	highlight.visible = on
