extends Sprite2D

@export var animator : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("burst_anim")
