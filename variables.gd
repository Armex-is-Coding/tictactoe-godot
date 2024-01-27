extends Node

@export var PlayerMark = "x"

var win_counter = {"x":0,"o":0}

signal update_game
signal on_win
signal on_draw
signal next_turn
signal on_replay
