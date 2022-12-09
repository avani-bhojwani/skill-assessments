# This R script will allow you to play a game of Tic-Tac-Toe
# against your computer using the command line.
cat("-----------\nBegin Round\n-----------\n")
Sys.sleep(1)

board <- data.frame(
  c(rep("[ ]", 3)),
  c(rep("[ ]", 3)),
  c(rep("[ ]", 3))
)
colnames(board) <- c(1, 2, 3)

cat("-------------\nCurrent Board\n-------------\n")
board
Sys.sleep(1)

if (interactive()) {
  con <- stdin()
} else {
  con <- "stdin"
}

#function for asking player whether they want to be X or O
get_symbol <- function() {
  cat("X or O? ")
  symbol <- readLines(con = con, n = 1)
  
  while (symbol != "X" & symbol != "O") {
    cat("Invalid input. X or O? ")
    symbol <- readLines(con = con, n = 1)
    Sys.sleep(1)
  }
  return(symbol)
}

#function for asking the player to choose a position for their turn
#and updating the board with their input
update_board_player <- function() {
  cat("Which row? ")
  row_position <- readLines(con = con, n = 1)
  cat("Which column? ")
  col_position <- readLines(con = con, n = 1)
  
  # check if row position or col position entered was empty
  if (is.null(row_position) | is.null(col_position)) {
    valid_position <- FALSE
    # check if position entered is outside the range of the board
    # i.e. not within the 3x3 dataframe
  } else if (is.null(board[row_position, col_position])) {
    valid_position <- FALSE
    # check if position entered is empty on the board
  } else if (board[row_position, col_position] == "[ ]") {
    valid_position <- TRUE
  } else {
    valid_position <- FALSE
  }

  while (valid_position == FALSE) {
    cat("Invalid input. \n")
    cat("Which row? ")
    row_position <- readLines(con = con, n = 1)
    cat("Which column? ")
    col_position <- readLines(con = con, n = 1)
    # check if row position or col position entered was empty
    if (is.null(row_position) | is.null(col_position)) {
      valid_position <- FALSE
      # check if position entered is outside the range of the board
      # i.e. not within the 3x3 dataframe
    } else if (is.null(board[row_position, col_position])) {
      valid_position <- FALSE
      # check if position entered is empty on the board
    } else if (board[row_position, col_position] == "[ ]") {
      valid_position <- TRUE
    } else {
      valid_position <- FALSE
    }
  }
  
  #update board and show it
  board[row_position, col_position] <- player_symbol
  Sys.sleep(1)
  cat("-------------\nCurrent Board\n-------------\n")
  print(board)
  Sys.sleep(1)
  return(board)
}

#function for selecting a position for the computer's turn
update_board_comp <- function() {
  # find which positions on the board are empty
  empty_positions <- which(board == "[ ]", arr.ind = TRUE)
  # choose an random position from the empty positions
  random_position <- sample(nrow(empty_positions), 1)
  row_position <- empty_positions[random_position, ][1]
  col_position <- empty_positions[random_position, ][2]
  #update board and show it
  board[row_position, col_position] <- comp_symbol
  Sys.sleep(1)
  cat("-------------\nCurrent Board\n-------------\n")
  print(board)
  Sys.sleep(1)
  return(board)
}

#This function checks if someone has won by seeing if there are 3 symbols
  #in a row on the board.
check_winner <- function() {
  x_win_vector <- c(rep("X", 3))
  o_win_vector <- c(rep("O", 3))
  empty_positions <- which(board == "[ ]", arr.ind = TRUE)

  end_round <- FALSE

  for (i in 1:nrow(board)) {
    #checking across rows
    if (identical(as.vector(t(board[i, ])), x_win_vector)) {
      print("X wins!")
      end_round <- TRUE
      break
    } else if (identical(as.vector(t(board[i, ])), o_win_vector)) {
      print("O wins!")
      end_round <- TRUE
      break
    #checking across columns
    } else if (identical(board[, i], x_win_vector)) {
      print("X wins!")
      end_round <- TRUE
      break
    } else if (identical(board[, i], o_win_vector)) {
      print("O wins!")
      end_round <- TRUE
      break
    #checking diagonally
    } else if (identical(c(board[1, 1], board[2, 2], board[3, 3]), x_win_vector) |
      identical(c(board[1, 3], board[2, 2], board[3, 1]), x_win_vector)) {
      print("X wins!")
      end_round <- TRUE
      break
    } else if (identical(c(board[1, 1], board[2, 2], board[3, 3]), o_win_vector) |
      identical(c(board[1, 3], board[2, 2], board[3, 1]), o_win_vector)) {
      print("O wins!")
      end_round <- TRUE
      break
    #checking if all positions are filled without a winner
    } else if (end_round == FALSE & length(empty_positions) == 0) {
      print("It's a tie!")
      end_round <- TRUE
      break
    } else {
      end_round <- FALSE
    }
  }
  return(end_round)
}

player_symbol <- get_symbol()

Sys.sleep(1)

end_game <- FALSE

#Player X always goes first, whether they are computer or human.
#Players will alternate taking turns until there is a winner or tie.
if (player_symbol == "X") {
  comp_symbol <- "O"
  while (end_game == FALSE) {
    cat("Player X turn\n")
    board <- update_board_player()
    end_game <- check_winner()
    if (end_game == FALSE) {
      cat("Player O turn\n")
      board <- update_board_comp()
      end_game <- check_winner()
    }
  }
} else {
  comp_symbol <- "X"
  while (end_game == FALSE) {
    cat("Player X turn\n")
    board <- update_board_comp()
    end_game <- check_winner()
    if (end_game == FALSE) {
      cat("Player O turn\n")
      board <- update_board_player()
      end_game <- check_winner()
    }
  }
}
