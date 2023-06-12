import random
import logging
import time

# Tic Tac Toe board
board = [[" " for _ in range(3)] for _ in range(3)]


def print_board(board):
    for row in board:
        print("| {} | {} | {} |".format(row[0], row[1], row[2]))


def user_move(symbol):
    while True:
        row = input("Select row for {} (1-3): ".format(symbol))
        col = input("Select column for {} (1-3): ".format(symbol))
        try:
            row = int(row) - 1
            col = int(col) - 1
            if row not in [0, 1, 2] or col not in [0, 1, 2]:
                logging.warning(
                    "Invalid position! Please enter a number from 1 to 3 for both row and column."
                )
            elif board[row][col] != " ":
                logging.warning("This position is already occupied!")
            else:
                board[row][col] = symbol
                break
        except ValueError:
            logging.warning(
                "Invalid input! Please enter a number from 1 to 3 for both row and column."
            )


def computer_move(symbol):
    while True:
        row = random.randint(0, 2)
        col = random.randint(0, 2)
        if board[row][col] == " ":
            board[row][col] = symbol
            break


def check_winner(board, symbol):
    # check rows
    for row in board:
        if row.count(symbol) == 3:
            return True
    # check columns
    for col in range(3):
        if [board[row][col] for row in range(3)].count(symbol) == 3:
            return True
    # check diagonals
    if (
        board[0][0] == board[1][1] == board[2][2] == symbol
        or board[0][2] == board[1][1] == board[2][0] == symbol
    ):
        return True
    return False


def choose_symbol():
    while True:
        symbol = input("Do you want to be X or O? ")
        if symbol not in ["X", "O"]:
            logging.warning("Invalid choice! Please choose either X or O.")
        else:
            return symbol


def play():
    player_symbol = choose_symbol()
    computer_symbol = "O" if player_symbol == "X" else "X"

    print_board(board)

    if player_symbol == "X":
        turn = "user"
    else:
        turn = "computer"

    while True:
        if turn == "user":
            user_move(player_symbol)
            turn = "computer"
        else:
            time.sleep(1)
            print("Computer is making a move...")
            time.sleep(1)
            computer_move(computer_symbol)
            turn = "user"

        print_board(board)
        if check_winner(board, player_symbol):
            print("You Win!")
            break
        elif check_winner(board, computer_symbol):
            print("Computer Wins!")
            break
        elif " " not in [item for sublist in board for item in sublist]:
            print("It's a tie!")
            break


if __name__ == "__main__":
    play()
