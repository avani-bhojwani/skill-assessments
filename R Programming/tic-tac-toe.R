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

update_board_player <- function() {
  cat("Which row? ")
  row_position <- readLines(con = con, n = 1)
  cat("Which column? ")
  col_position <- readLines(con = con, n = 1)
  if (is.null(board[row_position, col_position])) {
    valid_position <- FALSE
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
    if (is.null(board[row_position, col_position])) {
      valid_position <- FALSE
    } else if (board[row_position, col_position] == "[ ]") {
      valid_position <- TRUE
    } else {
      valid_position <- FALSE
    }
  }

  board[row_position, col_position] = player_symbol
  Sys.sleep(1)
  cat("-------------\nCurrent Board\n-------------\n")
  print(board)
  Sys.sleep(1)
  return(board)
}

update_board_comp <- function() {
  #find which positions on the board are empty
  empty_positions <- which(board == "[ ]", arr.ind = TRUE)
  #choose an random position from the empty positions
  random_position <- sample(nrow(empty_positions),1)
  row_position <- empty_positions[random_position,][1]
  col_position <- empty_positions[random_position,][2]
  board[row_position, col_position] = comp_symbol
  Sys.sleep(1)
  cat("-------------\nCurrent Board\n-------------\n")
  print(board)
  Sys.sleep(1)
  return(board)
}

check_winner <- function() {
  x_win_vector <- c(rep("X",3))
  o_win_vector <- c(rep("O",3))
  empty_positions <- which(board == "[ ]", arr.ind = TRUE)
  
  for (i in 1:nrow(board)) {
    if (identical(as.vector(t(board[i,])), x_win_vector)) {
      print("X wins!")
      end_game <- TRUE
    } else if (identical(as.vector(t(board[i,])), o_win_vector)) {
      print("O wins!")
      end_game <- TRUE
    } else if (identical(board[,i], x_win_vector)) {
      print("X wins!")
      end_game <- TRUE
    } else if (identical(board[,i], o_win_vector)) {
      print("O wins!")
      end_game <- TRUE
    } else {
      end_game <- FALSE
    }
  }
  
  if (identical(c(board[1,1], board[2,2], board[3,3]), x_win_vector) | 
      identical(c(board[1,3], board[2,2], board[3,1]), x_win_vector)) {
    print("X wins!")
    end_game <- TRUE
  } else if (identical(c(board[1,1], board[2,2], board[3,3]), o_win_vector) | 
             identical(c(board[1,3], board[2,2], board[3,1]), o_win_vector)) {
    print("O wins!")
    end_game <- TRUE
  } else if (end_game == FALSE & length(empty_positions)==0) {
    print("It's a tie!")
    end_game <- TRUE
  }
  
  return(end_game)
}

player_symbol <- get_symbol()

Sys.sleep(1)

end_game <- FALSE

if (player_symbol == "X") {
  comp_symbol <- "O"
  while (end_game == FALSE) {
    cat("Player X turn\n")
    board <- update_board_player()
    end_game <- check_winner()
    print(end_game)
    if (end_game == FALSE) {
      cat("Player O turn\n")
      board <- update_board_comp()
      end_game <- check_winner()
      print(end_game)
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
