extends Node

var current_game_state
var is_tutorial := true
var current_day : int
signal day_change

enum GameState {
	MENU, #generate trail, deal 3 gear and park cards, gain canteen, shuffle all
	GAMESETUP, #get two year cards and pick one
	DAYONE,
	DAYTWO
}

func _ready():
	change_state(GameState.GAMESETUP)
	
func change_state(new_state:GameState):
	current_game_state = new_state
	match new_state:
		GameState.MENU:
			pass
		GameState.GAMESETUP:
			ScaleManager.setup()
		GameState.DAYONE:
			is_tutorial = false
			current_day = 1
		GameState.DAYTWO:
			current_day = 2
			day_change.emit()
