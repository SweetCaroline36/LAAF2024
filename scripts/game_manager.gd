extends Node

var current_game_state
var is_tutorial := true

enum GameState {
	MENU, #generate trail, deal 3 gear and park cards, gain canteen, shuffle all
	GAMESETUP, #get two year cards and pick one
	DAYONE
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
			print("day one")
