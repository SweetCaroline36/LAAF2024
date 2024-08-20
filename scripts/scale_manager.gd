extends Node2D

var weight_prefab = preload("res://scenes/weight.tscn")
var initialized_weights = []
var tutorial_weight
var active_weight:WeightObject

var number_of_weights := 1 #can change for different levels (maybe 1-2 for first level)
signal scales_changed
signal tutorial_weight_dragged

func setup():
	pass
	#generate_weights(number_of_weights)

func generate_weights(length:int, location:Vector2):
	#instantiate sites and add to instances deck
	for i in length:
		var new_weight = weight_prefab.instantiate()
		if GameManager.is_tutorial:
			new_weight.draggable = false
			tutorial_weight = new_weight
		initialized_weights.append(new_weight)
		new_weight.position = location
		new_weight.selected.connect(_on_weight_selected)
		new_weight.released.connect(_on_weight_released)
		new_weight.cancelled.connect(_on_weight_cancelled)
		#instanced_weight_deck.append(new_weight)
		get_tree().get_root().get_node("Game").add_child.call_deferred(new_weight)

func _on_weight_selected(moving_weight:WeightObject):
	active_weight = moving_weight
	
func _on_weight_released():
	#get closest scale side
	if active_weight:
		var overlapping_areas = active_weight.get_overlapping_areas()
		if overlapping_areas.size() > 0:
			var closest_area = overlapping_areas[0]
			var closest_dist = overlapping_areas[0].global_position.distance_to(active_weight.global_position)
			for close_area in overlapping_areas:
				var dist = close_area.global_position.distance_to(active_weight.global_position)
				if dist < closest_dist:
					closest_dist = dist
					closest_area = close_area

			if active_weight.current_zone == null and not GameManager.is_tutorial:
				generate_weights(1, Vector2(608, 320))
			elif active_weight.current_zone == 1 and not closest_area.is_in_group("left"):
				scales_changed.emit(active_weight, true, false)
			elif active_weight.current_zone == 2 and not closest_area.is_in_group("right"):
				scales_changed.emit(active_weight, false, false)
				#active_weight.position -= active_weight.global_position
			if closest_area.is_in_group("trash") and not GameManager.is_tutorial:
				#delete weight
				initialized_weights.pop_at(initialized_weights.find(active_weight))
				active_weight.queue_free()
			
			if closest_area.is_in_group("left") and not active_weight.current_zone == 1:
				active_weight.current_zone = Zone.LEFT
				scales_changed.emit(active_weight, true, true)
			elif closest_area.is_in_group("right") and not active_weight.current_zone == 2:
				active_weight.current_zone = Zone.RIGHT
				scales_changed.emit(active_weight, false, true)
			make_weight_child_of_scale(active_weight, closest_area)
			active_weight.snap_to_site(closest_area)
			active_weight = null
			
			if GameManager.is_tutorial:
				make_tutorial_weight_interactable(false)
				tutorial_weight_dragged.emit()
		else:
			cancel_move()

func _on_weight_cancelled():
	cancel_move()
	
func cancel_move():
	active_weight.return_to_prev()
	active_weight = null

func make_weight_child_of_scale(node, new_parent):
	var old_parent = node.get_parent()
	old_parent.remove_child(node)
	new_parent.add_child(node)
	node.set_owner(new_parent)

func make_tutorial_weight_interactable(on: bool):
	if tutorial_weight:
		tutorial_weight.draggable = on

func reset_scale():
	if initialized_weights.size():
		for weight in initialized_weights:
			weight.queue_free()
		initialized_weights = []

enum Zone {
	SPAWN,
	LEFT,
	RIGHT
}
