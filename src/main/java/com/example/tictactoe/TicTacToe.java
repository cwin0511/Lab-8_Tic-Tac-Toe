package com.example.tictactoe;

import java.util.Arrays;

/**
 * Simple TicTacToe board. Board coordinates are (row, col) with 0-based indices [0..2].
 * Players are 'O' and 'X'.
 */
public class TicTacToe {
    private final char[][] board = new char[3][3];
    private char lastPlayer = ' ';
    private int moves = 0;

    public TicTacToe() {
        for (char[] row : board) Arrays.fill(row, ' ');
    }

    /**
     * Place a player marker at (row, col).
     * @param row 0..2
     * @param col 0..2
     * @param player 'O' or 'X'
     * @return the new board Result after the move (ONGOING, O_WIN, X_WIN, DRAW)
     */
    public Result set(int row, int col, char player) {
        if (player != 'O' && player != 'X') throw new IllegalArgumentException("player must be 'O' or 'X'");
        if (row < 0 || row > 2 || col < 0 || col > 2) throw new IndexOutOfBoundsException("row and col must be 0..2");
        if (board[row][col] != ' ') throw new IllegalStateException("cell already occupied");
        // enforce alternating turns
        if (moves > 0 && player == lastPlayer) throw new IllegalStateException("players must alternate");
        // also if game already finished, disallow further sets
        Result current = evaluate();
        if (current != Result.ONGOING) throw new IllegalStateException("game already finished: " + current);

        board[row][col] = player;
        lastPlayer = player;
        moves++;
        // return evaluation after this move
        return evaluate();
    }

    /**
     * Evaluate current board state.
     * @return Result (O_WIN, X_WIN, DRAW, ONGOING)
     */
    public Result evaluate() {
        // check rows and cols
        for (int i = 0; i < 3; i++) {
            if (board[i][0] != ' ' && board[i][0] == board[i][1] && board[i][1] == board[i][2]) {
                return board[i][0] == 'O' ? Result.O_WIN : Result.X_WIN;
            }
            if (board[0][i] != ' ' && board[0][i] == board[1][i] && board[1][i] == board[2][i]) {
                return board[0][i] == 'O' ? Result.O_WIN : Result.X_WIN;
            }
        }
        // diagonals
        if (board[0][0] != ' ' && board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
            return board[0][0] == 'O' ? Result.O_WIN : Result.X_WIN;
        }
        if (board[0][2] != ' ' && board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
            return board[0][2] == 'O' ? Result.O_WIN : Result.X_WIN;
        }

        if (moves == 9) return Result.DRAW;
        return Result.ONGOING;
    }

    public char[][] getBoardCopy() {
        char[][] copy = new char[3][3];
        for (int i = 0; i < 3; i++) System.arraycopy(board[i], 0, copy[i], 0, 3);
        return copy;
    }
}
