//
//  ViewController.swift
//  Tilak_c0868747_FT
//
//  Created by Tilak Acharya on 2022-11-07.
//

import UIKit

class ViewController: UIViewController {
    
    let numList = 1...999
    var currentNumber = 0
    var lastNumber : Int? = nil
    
    var score = 0
    
    
    var myProgress:Array<GameModel> = []

    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelDisplayNumber: UILabel!
    
    @IBOutlet weak var btnEven: UIButton!
    
    @IBOutlet weak var ivResult: UIImageView!
    @IBOutlet weak var btnOdd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        putBackgroundImage()
        startGame()
    }
    
    @IBAction func resetGame(_ sender: Any) {
        
        let alert = UIAlertController(title: "Reset Game", message: "Are you sure ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes!", style: .default){
            _ in
            self.resetGame()
            self.startGame()
        })
        alert.addAction(UIAlertAction(title: "No!", style: .cancel))
        present(alert, animated: true)
        
    }
    func putBackgroundImage(){
        
        let bg = UIImage(named: "bg_1")
        let iv = UIImageView(frame: view.bounds)

        iv.clipsToBounds = true
        iv.image = bg
        iv.center = view.center
        view.addSubview(iv)
        self.view.sendSubviewToBack(iv)
        
    }
    
    func startGame(){
        let newNum = numList.randomElement() ?? 0
        
        if lastNumber == newNum {
            startGame()
        }
        else{
            currentNumber = newNum
            
            labelDisplayNumber.text = "\(currentNumber)"
            ivResult.isHidden = true
        }
        
        
    }
    func displayCurrentNumber(){
        labelDisplayNumber.text = "\(currentNumber)"
    }


    @IBAction func chooseOdd(_ sender: Any) {
        
        let isEven = checkOddEven(num: currentNumber)
        
        updateProgress(num: currentNumber, input: false, output: !isEven)
        
    }
    @IBAction func chooseEven(_ sender: Any) {
        let isEven = checkOddEven(num: currentNumber)
        
        updateProgress(num: currentNumber, input: true, output: isEven)
    }
    
    func checkOddEven(num:Int) -> Bool{
        return (num % 2 == 0)
    }
    
    func resetGame(){
        resetScore()
        updateScoreValue()
        
        currentNumber = 0
        lastNumber = nil
        myProgress = []
        ivResult.isHidden = true
    }
    
    func resetScore(){
        score = 0
    }
    func updateScoreValue(){
        labelScore.text = "Score : \(score)"
    }
    
    func addScore(){
        score += 1
        updateScoreValue()
    }
    
    func updateProgress(num:Int,input:Bool,output:Bool){
        
        lastNumber = num
        
        let gameModel = GameModel(number: num, myChoice: input, result: output)
        myProgress.append(gameModel)
        ivResult.isHidden = false
        
        var alertMessage = ""
        if output {
            ivResult.image = UIImage(named: "correct")
            alertMessage = "Congratulations ! Your answer is correct."
            addScore()
        }
        else{
            ivResult.image = UIImage(named: "incorrect")
            var correctOutput = ""
            if(input){
                correctOutput = "Odd"
            }
            else{
                correctOutput = "Even"
            }
            alertMessage = "Oops.. Wrong answer.. Correct answer is \(correctOutput)"
        }
        
       
        
        let alert = UIAlertController(title: "Result", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again!", style: .default){
            _ in
            self.startGame()
        })
        
        alert.addAction(UIAlertAction(title: "Show Progress", style: .default){
            _ in
            self.showProgress(progress: self.myProgress)
        })
        present(alert, animated: true)
    }
    
    
    
    func showProgress(progress:Array<GameModel>){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Progress") as! ProgressViewController
        nextViewController.delegate = self
        nextViewController.myProgress = progress
        self.present(nextViewController, animated: true)

    }
}

