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
    @IBOutlet weak var buttonTextPause: UIButton!
    @IBOutlet weak var textMoves: UILabel!
    @IBOutlet weak var textTime: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var ourTimer = Timer()
    var timerIsOn = false
    var board: BoardModel? = nil
    var movesToDisplay: Int = 0
    var timeToDisplay: Int = 0
    var firstButtonX: Int? = nil
    var firstButtonY: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board = BoardModel()
        if (board != nil) {
            movesToDisplay = board!.getMoves()
            timeToDisplay = board!.getTime()
        }
        
        print("viewDidLoad")
        loadSavedData()
        UpdateUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        saveDataBeforeClosing()
    }
    
    func getTime() -> Int {
        return timeToDisplay
    }
    
    func getTimerStatus() -> Bool {
        return timerIsOn
    }
    
    func saveDataBeforeClosing() -> Void {
        let defaults = UserDefaults.standard
        defaults.set(movesToDisplay, forKey: DefaultKeys.keyMoves)
        defaults.set(timeToDisplay, forKey: DefaultKeys.keyTime)
        defaults.set(timerIsOn, forKey: DefaultKeys.keyTimerStatus)
        
        let jsonEncoder = JSONEncoder()
        let jsonData = ((try? jsonEncoder.encode(board)) ?? nil)!
        defaults.set(jsonData, forKey: DefaultKeys.keyBoardModelJson)
    }
    
    func loadSavedData() -> Void {
        let defaults = UserDefaults.standard
        if let stringMoves = defaults.string(forKey: DefaultKeys.keyMoves) {
            movesToDisplay = (stringMoves as NSString).integerValue
        }
        if let stringTime = defaults.string(forKey: DefaultKeys.keyTime) {
            timeToDisplay = (stringTime as NSString).integerValue
        }
        if let stringTimerStatus = defaults.string(forKey: DefaultKeys.keyTimerStatus) {
            timerIsOn = UserDefaults.standard.bool(forKey: DefaultKeys.keyTimerStatus)
        }
        if let jsonBoardModel = defaults.object(forKey: DefaultKeys.keyBoardModelJson) as? Data{
            let jsonDecoder = JSONDecoder()
            let boardModel = try? jsonDecoder.decode(BoardModel.self, from: jsonBoardModel)
            if (boardModel != nil) {
                board = boardModel
                StartTimer()
            }
        }
    }
    
    func UpdateUI() -> Void {
        if (board != nil) {
            movesToDisplay = board!.getMoves()
            
            textMoves.text = "Moves: \(movesToDisplay)"
            
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
    
    // MARK: - TimerFunctions
    func StartTimer() -> Void {
        ourTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ActionTimer), userInfo: nil, repeats: true)
        buttonTextPause.setTitle("Pause", for: UIControl.State.normal)
        timerIsOn = true
    }
    
    func PauseTimer() -> Void {
        ourTimer.invalidate()
        buttonTextPause.setTitle("Unpause", for: UIControl.State.normal)
        timerIsOn = false
    }
    
    func ResetTimer() -> Void {
        ourTimer.invalidate()
        timeToDisplay = 0
        textTime.text = "Time: \(timeToDisplay)"
        buttonTextPause.setTitle("Pause", for: UIControl.State.normal)
        timerIsOn = false
    }
    
    @objc func ActionTimer() {
        timeToDisplay += 1
        if (timeToDisplay < 60) {
            textTime.text = "Time: \(timeToDisplay)"
        } else {
            if (timeToDisplay % 59 < 10) {
                textTime.text = "Time: \(((timeToDisplay) - timeToDisplay % 59) / 59):0\(timeToDisplay % 59)"
            } else {
                textTime.text = "Time: \(((timeToDisplay) - timeToDisplay % 59) / 59):\(timeToDisplay % 59)"
            }
        }
        
    }
    
    // MARK: - WinDialog
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "You Won!", message: "Enter your name to save results!", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let name = alertController.textFields?[0].text
            
            self.tempLabel.text = "\(name!) - \(self.movesToDisplay) - \(self.timeToDisplay)"
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func newGameClicked(_ sender: UIButton) {
        if (board != nil) {
            board!.shuffleBoard()
            board!.setMoves(i: 0)
            board!.setTime(i: 0)
            ResetTimer()
            UpdateUI()
        }
    }
    
    @IBAction func pauseClicked(_ sender: UIButton) {
        if (!board!.checkIfWinner()) {
            if (timerIsOn) {
                PauseTimer()
            } else {
                StartTimer()
            }
        }
    }
    
    @IBAction func button00Clicked(_ sender: UIButton) {
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
    // MARK: - ButtonClicked
    func buttonClicked(x: Int, y: Int) -> Void {
        if (!board!.checkIfWinner()) {
            if (firstButtonX == nil) {
                firstButtonX = x
                firstButtonY = y
            } else if (firstButtonY != nil) {
                print("buttonClicked firstButtonX:\(firstButtonX) firstButtonY:\(firstButtonY) x:\(x) y:\(y)")
                if (!timerIsOn) {
                    StartTimer()
                }
                board!.makeMove(firstX: firstButtonX!, firstY: firstButtonY!, secondX: x, secondY: y)
                if (board!.checkIfWinner()) {
                    showInputDialog()
                    PauseTimer()
                }
                firstButtonX = nil
                firstButtonY = nil
                
                UpdateUI()
            }
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
