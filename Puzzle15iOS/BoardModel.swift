//
//  BoardModel.swift
//  Puzzle15iOS
//
//  Created by Артём Любоженко on 02.01.2022.
//

import Foundation

class BoardModel {
    var moves: Int = 0
    var time: Int = 0
    var boardArray: [[Int]] = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]]
    var pause: Bool = false
    
    func getBoard() -> [[Int]] {
        return boardArray
    }
    
    func getMoves() -> Int {
        return moves
    }
    
    func setMoves(i: Int) -> Void {
        moves = i
    }
    
    func getTime() -> Int {
        return time
    }
    
    func setTime(i: Int) -> Void {
        time = i
    }
    
    func refreshBoard() -> Void {
        boardArray = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]]
    }
    
    func makeMove(firstX: Int, firstY: Int, secondX: Int, secondY: Int) -> Void {
        if (checkCanIMove(firstX: firstX, firstY: firstY, secondX: secondX, secondY: secondY)) {
            // for debuging
            print("makeMove firstX:\(firstX) firstY:\(firstY) secondX:\(secondX) secondY:\(secondY)")
            let tempFirst = boardArray[firstX][firstY]
            boardArray[firstX][firstY] = boardArray[secondX][secondY]
            boardArray[secondX][secondY] = tempFirst
            moves += 1
        }
    }
    
    func checkCanIMove(firstX: Int, firstY: Int, secondX: Int, secondY: Int) -> Bool {
        if (firstX < 0 || firstX > 3 || firstY < 0 || firstY > 3 || secondX < 0 || secondX > 3 || secondY < 0 || secondY > 3) {
            return false
        }
        let xSide = firstY - secondY
        let ySide = firstX - secondX
        if (firstX != secondX || firstY != secondY) {
            if (boardArray[firstX][firstY] == 0 || boardArray[secondX][secondY] == 0) {
                if (xSide == 0) {
                    return (ySide == -1 || ySide == 0 || ySide == 1)
                } else if (xSide == -1 || xSide == 1) {
                    return (ySide == 0)
                } else {
                    return false
                }
            }
        }
        return false
    }
    
    func shuffleBoard() -> Void {
        refreshBoard()
        var x = 0
        var rndFirstX = 3
        var rndFirstY = 3
        while (x != 250) {
            // Int.random(in: 1..<100)
            let rndSecondX = Int.random(in: 0..<4)
            let rndSecondY = Int.random(in: 0..<4)
            if (checkCanIMove(firstX: rndFirstX, firstY: rndFirstY, secondX: rndSecondX, secondY: rndSecondY)) {
                makeMove(firstX: rndFirstX, firstY: rndFirstY, secondX: rndSecondX, secondY: rndSecondY)
                rndFirstX = rndSecondX
                rndFirstY = rndSecondY
            }
            x += 1
        }
    }
}
