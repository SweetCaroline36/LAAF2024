extends Node2D
class_name Scale

@onready var top = %Top

var weights_on_scale := [0, 0]
# Called when the node enters the scene tree for the first time.
func _ready():
	ScaleManager.scales_changed.connect(_on_scale_manager_scales_changed)

func _on_scale_manager_scales_changed(weight:WeightObject, side:bool, adding:bool): #left is true, right is false
	if adding:
		weights_on_scale[0 if side else 1] += weight.weight
	else:
		weights_on_scale[0 if side else 1] -= weight.weight			
	var rotation_destination = weights_on_scale[1] - weights_on_scale[0]
	rotation_destination = clamp(rotation_destination, -1.25, 1.25)
	top.rotate_scale(rotation_destination)

func example_tilt(right_down:bool):
	top.rotate_scale(0.3 if right_down else -0.3)

func reset_scale():
	top.rotate_scale(0)
	ScaleManager.reset_scale()
	weights_on_scale = [0, 0]
	
