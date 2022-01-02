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
    
    func getTime() -> Int {
        return time
    }
    
    func refreshBoard() -> Void {
        boardArray = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]]
    }
    
    func makeMove(firstX: Int, firstY: Int, secondX: Int, secondY: Int) -> Void {
            if (checkCanIMove(fX: firstX, fY: firstY, sX: secondX, sY: secondY)) {
                print("makeMove firstX:\(firstX) firstY:\(firstY) secondX:\(secondX) secondY:\(secondY)")
                let tempFirst = boardArray[firstX][firstY]
                boardArray[firstX][firstY] = boardArray[secondX][secondY]
                boardArray[secondX][secondY] = tempFirst
                moves += 1
            }
    }

    func checkCanIMove(fX: Int, fY: Int, sX: Int, sY: Int) -> Bool {
        let xSide = fY - sY
        let ySide = fX - sX
        if (fX != sX || fY != sY) {
            if (xSide == 0) {
                return (ySide == -1 || ySide == 0 || ySide == 1)
            } else if (xSide == -1 || xSide == 1) {
                return (ySide == 0)
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
