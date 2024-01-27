extends Node

var tictactoepanels:Array
var board = [
	[ "", "", "" ],
	[ "", "", "" ],
	[ "", "", "" ]
]

func _ready():
	Variables.update_game.connect(checkForWin)
	Variables.on_win.connect(onWin)
	Variables.on_draw.connect(onDraw)
	Variables.on_replay.connect(onReplay)
	Variables.next_turn.connect(changeTurn)
	
	init_game()

func init_game():
	tictactoepanels = $Game/TicTacToePanels.get_children()

	# Populate the board from tictactoepanels
	for i in range(len(tictactoepanels)):
		tictactoepanels[i].current_value = ""
		# Calculate the row and column indices based on the current index
		var row = i / 3  # Integer division to get the row index
		var col = i % 3   # Modulo operation to get the column index

		# Assign the value from tictactoepanel to the corresponding cell in the board
		board[row][col] = tictactoepanels[i]
	pass

func changeTurn():
	if Variables.PlayerMark == "x":
		Variables.PlayerMark = "o"
	elif Variables.PlayerMark == "o":
		Variables.PlayerMark = "x"
	$Interface/CurrentTurnValue.text = Variables.PlayerMark

func checkForWin():
	# check for win
	# Check rows
	for row in board:
		if (row[0].current_value == row[1].current_value and row[1].current_value == row[2].current_value and row[0].current_value != ""):
			Variables.on_win.emit()

	## Check columns
	for col in range(3):
		if (board[0][col].current_value == board[1][col].current_value and board[1][col].current_value == board[2][col].current_value and board[0][col].current_value != ""):
			Variables.on_win.emit()

	## Check diagonals
	if board[0][0].current_value == board[1][1].current_value and board[1][1].current_value == board[2][2].current_value and board[0][0].current_value != "":
		Variables.on_win.emit()
	
	if board[0][2].current_value == board[1][1].current_value and board[1][1].current_value == board[2][0].current_value and board[0][2].current_value != "":
		Variables.on_win.emit()

	# check for draw
	var count_empty = 0
	for i in range(len(tictactoepanels)):
		if tictactoepanels[i].current_value == "":
			count_empty += 1
	if count_empty == 0:
		Variables.on_draw.emit()
	
			
func onReplay():
	for item in board:
		for yitem in item:
			yitem.reset()
	$WinScreen.hide()
	$DrawScreen.hide()
	$Game.show()
	pass

func onWin():
	$Game.hide()
	$WinScreen.show()
	Variables.win_counter[Variables.PlayerMark] += 1

	$Interface/XWinCounter.text =  str("x : " , Variables.win_counter["x"])
	$Interface/OWinCounter.text =  str("o : " , Variables.win_counter["o"])

func onDraw():
	$Game.hide()
	$DrawScreen.show()
