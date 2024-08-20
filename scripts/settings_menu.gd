extends Control

var music = AudioServer.get_bus_index("Master")

func _ready():
	$"%VolumeSlider".value = db_to_linear(music)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music, linear_to_db(value))
