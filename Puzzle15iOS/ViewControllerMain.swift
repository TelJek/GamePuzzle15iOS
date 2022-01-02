//
//  ViewControllerMain.swift
//  Puzzle15iOS
//
//  Created by Артём Любоженко on 01.01.2022.
//

import UIKit

class ViewControllerMain: UIViewController {


    @IBOutlet weak var button00: UIButton!
    @IBOutlet weak var button01: UIButton!
    @IBOutlet weak var button02: UIButton!
    @IBOutlet weak var button03: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button20: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button30: UIButton!
    @IBOutlet weak var button31: UIButton!
    @IBOutlet weak var button32: UIButton!
    @IBOutlet weak var button33: UIButton!
    @IBOutlet weak var textMoves: UILabel!
    
    var board: BoardModel? = nil
    var movesToOutput: Int = 0
    var timeToOutput: Int = 0
    var firstButtonX: Int? = nil
    var firstButtonY: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        board = BoardModel()
        if (board != nil) {
            movesToOutput = board!.getMoves()
            timeToOutput = board!.getTime()
        }
        updateUI()
        // Do any additional setup after loading the view.
    }

    func updateUI() -> Void {
        if (board != nil) {
            movesToOutput = board!.getMoves()
            timeToOutput = board!.getTime()
            
            textMoves.text = "Moves: \(movesToOutput)"
            
            button00.setTitle("\(board!.getBoard()[0][0])", for: UIControl.State.normal)
            button01.setTitle("\(board!.getBoard()[0][1])", for: UIControl.State.normal)
            button02.setTitle("\(board!.getBoard()[0][2])", for: UIControl.State.normal)
            button03.setTitle("\(board!.getBoard()[0][3])", for: UIControl.State.normal)
            button10.setTitle("\(board!.getBoard()[1][0])", for: UIControl.State.normal)
            button11.setTitle("\(board!.getBoard()[1][1])", for: UIControl.State.normal)
            button12.setTitle("\(board!.getBoard()[1][2])", for: UIControl.State.normal)
            button13.setTitle("\(board!.getBoard()[1][3])", for: UIControl.State.normal)
            button20.setTitle("\(board!.getBoard()[2][0])", for: UIControl.State.normal)
            button21.setTitle("\(board!.getBoard()[2][1])", for: UIControl.State.normal)
            button22.setTitle("\(board!.getBoard()[2][2])", for: UIControl.State.normal)
            button23.setTitle("\(board!.getBoard()[2][3])", for: UIControl.State.normal)
            button30.setTitle("\(board!.getBoard()[3][0])", for: UIControl.State.normal)
            button31.setTitle("\(board!.getBoard()[3][1])", for: UIControl.State.normal)
            button32.setTitle("\(board!.getBoard()[3][2])", for: UIControl.State.normal)
            button33.setTitle("\(board!.getBoard()[3][3])", for: UIControl.State.normal)
        }
    }
    
    @IBAction func button00Clicked(_ sender: UIButton) {
        // button00.setTitle("-", for: UIControl.State.normal)
        // updateUI()
        print("button00Clicked")
        buttonClicked(x: 0, y: 0)
    }
    @IBAction func button01Clicked(_ sender: UIButton) {
        print("button01Clicked")
        buttonClicked(x: 0, y: 1)
    }
    @IBAction func button02Clicked(_ sender: UIButton) {
        print("button02Clicked")
        buttonClicked(x: 0, y: 2)
    }
    @IBAction func button03Clicked(_ sender: UIButton) {
        print("button03Clicked")
        buttonClicked(x: 0, y: 3)
    }
    @IBAction func button10Clicked(_ sender: UIButton) {
        print("button10Clicked")
        buttonClicked(x: 1, y: 0)
    }
    @IBAction func button11Clicked(_ sender: UIButton) {
        print("button11Clicked")
        buttonClicked(x: 1, y: 1)
    }
    @IBAction func button12Clicked(_ sender: UIButton) {
        print("button12Clicked")
        buttonClicked(x: 1, y: 2)
    }
    @IBAction func button13Clicked(_ sender: UIButton) {
        print("button13Clicked")
        buttonClicked(x: 1, y: 3)
    }
    @IBAction func button20Clicked(_ sender: UIButton) {
        print("button20Clicked")
        buttonClicked(x: 2, y: 0)
    }
    @IBAction func button21Clicked(_ sender: UIButton) {
        print("button21Clicked")
        buttonClicked(x: 2, y: 1)
    }
    @IBAction func button22Clicked(_ sender: UIButton) {
        print("button22Clicked")
        buttonClicked(x: 2, y: 2)
    }
    @IBAction func button23Clicked(_ sender: UIButton) {
        print("button23Clicked")
        buttonClicked(x: 2, y: 3)
    }
    @IBAction func button30Clicked(_ sender: UIButton) {
        print("button30Clicked")
        buttonClicked(x: 3, y: 0)
    }
    @IBAction func button31Clicked(_ sender: UIButton) {
        print("button31Clicked")
        buttonClicked(x: 3, y: 1)
    }
    @IBAction func button32Clicked(_ sender: UIButton) {
        print("button32Clicked")
        buttonClicked(x: 3, y: 2)
    }
    @IBAction func button33Clicked(_ sender: UIButton) {
        print("button33Clicked")
        buttonClicked(x: 3, y: 3)
    }
    
    func buttonClicked(x: Int, y: Int) -> Void {
        if (firstButtonX == nil) {
            firstButtonX = x
            firstButtonY = y
        } else if (firstButtonY != nil) {
            print("buttonClicked firstButtonX:\(firstButtonX) firstButtonY:\(firstButtonY) x:\(x) y:\(y)")
            board?.makeMove(firstX: firstButtonX!, firstY: firstButtonY!, secondX: x, secondY: y)
            firstButtonX = nil
            firstButtonY = nil

            updateUI()
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
