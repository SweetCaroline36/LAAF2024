extends Node2D

var weight_prefab = preload("res://scenes/weight.tscn")
var tutorial_weight
var active_weight:WeightObject
var tutorial := true

var number_of_weights := 1 #can change for different levels (maybe 1-2 for first level)
signal scales_changed
signal tutorial_weight_dragged

func setup():
	pass
	#generate_weights(number_of_weights)

func generate_weights(length:int, location:Vector2, tut_weight:bool):
	#instantiate sites and add to instances deck
	for i in length:
		var new_weight = weight_prefab.instantiate()
		if tutorial:
			new_weight.draggable = false
			tutorial_weight = new_weight
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
			#snap to closest
			print("starting zone: " + str(active_weight.current_zone))
			print(closest_area.global_position)
			print(active_weight.global_position)
			if active_weight.current_zone == null and not tutorial:
				generate_weights(1, Vector2(800, 0), false)
				#active_weight.position -= active_weight.global_position
			if closest_area.is_in_group("trash"):
				#delete weight
				active_weight.queue_free()
			
			if closest_area.is_in_group("left"):
				active_weight.current_zone = Zone.LEFT
				scales_changed.emit(active_weight, true)
			elif closest_area.is_in_group("right"):
				active_weight.current_zone = Zone.RIGHT
				scales_changed.emit(active_weight, false)
			#active_weight.snap_to_site(closest_area)
			active_weight.position -= active_weight.global_position
			print(active_weight.global_position)
			make_weight_child_of_scale(active_weight, closest_area)
			active_weight = null
			if tutorial:
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

func make_tutorial_weight_interactable():
	print(tutorial_weight)
	if tutorial_weight:
		tutorial_weight.draggable = true

enum Zone {
	SPAWN,
	LEFT,
	RIGHT
}
