from random import randint, choice
from os import system as bash
from time import time


def intInput(StringToDisplay):
    # Simply checks that input is valid integer
    while True:
        try:
            x = int(input(StringToDisplay))
            return x
            break
        except ValueError:
            print('Input integer number, please')
        except Exception:
            print('Unexpected error or keyboard interrupt')


def drawBoard():
    print('\
 ╔═══╦═══╦═══╗\n\
 ║ {0} ║ {1} ║ {2} ║\n\
 ╠═══╬═══╬═══╣\n\
 ║ {3} ║ {4} ║ {5} ║\n\
 ╠═══╬═══╬═══╣\n\
 ║ {6} ║ {7} ║ {8} ║\n\
 ╚═══╩═══╩═══╝ '.format(
               board_status[7], board_status[8], board_status[9],
               board_status[4], board_status[5], board_status[6],     
               board_status[1], board_status[2], board_status[3]))


def askPlayerLetter():
    # Function that asks which letter player wants to use
    print('Do you want to be X or O?')
    Letter = input().upper()
    while Letter != 'X' and Letter != 'O':
        print('Please type appropriate symbol')
        Letter = input('Prompt: ').upper()
    if Letter == 'X':  # then X will be used by player; O by computer
        return ['X', 'O']
    else:
        return ['O', 'X']


def whoGoesFirst():
    # Timer used to count 0.75 seconds while displaying who goes first
    if randint(0, 1) == 0:
        CurrentTime, Timer = time(), time() + 0.75
        print('You go first')
        while Timer > CurrentTime:
            CurrentTime = time()
        return 'player'
    else:
        CurrentTime, Timer = time(), time() + 0.75
        print('Computer goes first')
        while Timer > CurrentTime:
            CurrentTime = time()
        return 'computer'


def makeMove(Board, Move, Letter):
    Board[Move] = Letter


def isSpaceFree(Board, Move):
    return Board[Move] == ' '


def playerMove():
    Move = 0
    while not (0 < Move < 10) or not (isSpaceFree(board_status, int(Move))):
        Move = intInput('Enter your move: ')
    return int(Move)


def isWinner(brd, lttr):
    # Returns a boolean value. brd (board) and lttr (letter) used to make
    # code block compact.
    return ((brd[7] == lttr and brd[8] == lttr and brd[9] == lttr) or
            (brd[4] == lttr and brd[5] == lttr and brd[6] == lttr) or
            (brd[1] == lttr and brd[2] == lttr and brd[3] == lttr) or
            (brd[7] == lttr and brd[5] == lttr and brd[3] == lttr) or
            (brd[9] == lttr and brd[5] == lttr and brd[1] == lttr) or
            (brd[7] == lttr and brd[4] == lttr and brd[1] == lttr) or
            (brd[8] == lttr and brd[5] == lttr and brd[2] == lttr) or
            (brd[9] == lttr and brd[6] == lttr and brd[3] == lttr))


def computerMove():
    '''
    Simple AI that checks
    1)Can computer win in the next move
    2)Can player win in the next move
    3)Is there any free corner
    4)Is center is free
    5)Is there any free side
    And returns a move digit

    '''


    for i in range(1, 10):
        Copy = board_status.copy()
        if isSpaceFree(Copy, i):
            makeMove(Copy, i, ComputerLetter)
            if isWinner(Copy, ComputerLetter):
                return i

    for i in range(1, 10):
        Copy = board_status.copy()
        if isSpaceFree(Copy, i):
            makeMove(Copy, i, PlayerLetter)
            if isWinner(Copy, PlayerLetter):
                return i

    move = randomMoveFromList([7, 9, 1, 3])
    if move is not None:
        return move

    if isSpaceFree(board_status, 5):
        return 5

    move = randomMoveFromList([8, 4, 2, 6])
    if move is not None:
        return move


def randomMoveFromList(MovesList):
    PossibleMoves = []
    for i in MovesList:
        if isSpaceFree(board_status, i):
            PossibleMoves.append(i)
    if len(PossibleMoves) != 0:
        return choice(PossibleMoves)
    else:
        return None


def isBoardFull():
    for i in range(1, 10):
        if isSpaceFree(board_status, i):
            return False
    return True


def playAgain():
    print('Do you want to play again? [y/N]')
    PlayAgainInput = input().lower()
    return (PlayAgainInput.startswith('y') or PlayAgainInput == '')

# "bash('cls')" function simply clss the screen of the terminal.
# If you want run this script on system that uses other shell then
# substitute "cls" with a command that your shell uses to cls the screen
# P.S. for windows it is "cls".

bash('cls')
print('Welcome to Tic Tac Toe')
PlayAgainWish = True
print('To win, you have to place 3 X-s or O-s in a row.\n\
Use NumPad to enter your move (!). Here is the key map.')
board_status = ['', 1, 2, 3, 4, 5, 6, 7, 8, 9]
drawBoard()
print('You have to be sure that you are making move to a free cell.\n\n')
PlayerLetter, ComputerLetter = askPlayerLetter()
while PlayAgainWish:
    bash('cls')
    board_status = 10 * [' ']
    turn = whoGoesFirst()
    while True:
        if turn == 'player':
            bash('cls')
            print('   YOUR MOVE')
            drawBoard()
            move = playerMove()
            makeMove(board_status, move, PlayerLetter)
            turn = 'computer'
            if isWinner(board_status, PlayerLetter):
                bash('cls')
                print('Hooray, you have won the game!')
                drawBoard()
                PlayAgainWish = playAgain()
                break
            elif isBoardFull():
                bash('cls')
                print("It's a tie!")
                drawBoard()
                PlayAgainWish = playAgain()
                break
        else:
            # All this dots and timers are used to make animation of
            # computer moving. You will understand if you will run the script.
            for i in ['', '.', '..', '...']:
                bash('cls')
                print(' Computer is making move' + i)
                drawBoard()
                CurrentTime, Timer = time(), time() + 0.15
                while Timer > CurrentTime:
                    CurrentTime = time()
                if i == '..':
                    move = computerMove()
                    makeMove(board_status, move, ComputerLetter)
                    turn = 'player'
            if isWinner(board_status, ComputerLetter):
                bash('cls')
                print('Oops, you lose!')
                drawBoard()
                PlayAgainWish = playAgain()
                break
            elif isBoardFull():
                bash('cls')
                print("It's a tie!")
                DrawBoard()
                PlayAgainWish = playAgain()
                break