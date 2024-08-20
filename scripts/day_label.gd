extends RichTextLabel

@export var animator: AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.day_change.connect(_on_gm_day_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_gm_day_change():
	text = "[center]Day " + str(GameManager.current_day)
	animator.play("end_of_day")
