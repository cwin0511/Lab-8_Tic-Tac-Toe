package com.example.tictactoe;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class TicTacToeTest {

    @Test
    public void testOWinRow() {
        TicTacToe t = new TicTacToe();
        t.set(0,0,'O');
        t.set(1,0,'X');
        t.set(0,1,'O');
        t.set(1,1,'X');
        Result r = t.set(0,2,'O');
        assertEquals(Result.O_WIN, r);
    }

    @Test
    public void testXWinDiag() {
        TicTacToe t = new TicTacToe();
        t.set(0,0,'O');
        t.set(0,2,'X');
        t.set(1,0,'O');
        t.set(1,1,'X');
        t.set(2,1,'O');
        Result r = t.set(2,0,'X');
        // X has diagonal 0,2 - 1,1 - 2,0
        assertEquals(Result.X_WIN, r);
    }

    @Test
    public void testDraw() {
        TicTacToe t = new TicTacToe();
        // sequence leads to a draw
        t.set(0,0,'O');
        t.set(0,1,'X');
        t.set(0,2,'O');
        t.set(1,1,'X');
        t.set(1,0,'O');
        t.set(1,2,'X');
        t.set(2,1,'O');
        t.set(2,0,'X');
        Result r = t.set(2,2,'O');
        assertEquals(Result.DRAW, r);
    }

    @Test
    public void testInvalidMovesAndAlternation() {
        TicTacToe t = new TicTacToe();
        t.set(0,0,'O');
        // placing same player twice in a row should fail
        assertThrows(IllegalStateException.class, () -> t.set(1,1,'O'));

        // placing on occupied cell
        assertThrows(IllegalStateException.class, () -> t.set(0,0,'X'));

        // invalid player
        assertThrows(IllegalArgumentException.class, () -> t.set(2,2,'A'));
    }

    @Test
    public void testGameStopsAfterWin() {
        TicTacToe t = new TicTacToe();
        t.set(0,0,'O');
        t.set(1,0,'X');
        t.set(0,1,'O');
        t.set(1,1,'X');
        Result r = t.set(0,2,'O');
        assertEquals(Result.O_WIN, r);
        // further moves should be disallowed
        assertThrows(IllegalStateException.class, () -> t.set(2,2,'X'));
    }
}
