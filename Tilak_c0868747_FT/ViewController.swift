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
    
    struct GameModel{
        var number:Int
        var myChoice:Bool
        var result:Bool
        init(number: Int, myChoice: Bool, result: Bool) {
            self.number = number
            self.myChoice = myChoice
            self.result = result
        }
    }
    var myProgress:Array<GameModel> = []

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
        else {
            currentNumber = newNum
        }
        
        labelDisplayNumber.text = "\(currentNumber)"
        ivResult.isHidden = true
        
    }
    func displayCurrentNumber(){
        labelDisplayNumber.text = "\(currentNumber)"
    }


    @IBAction func chooseOdd(_ sender: Any) {
        
        let isEven = checkOddEven(num: currentNumber)
        updateProgress(num: currentNumber, input: false, output: isEven)
        
    }
    @IBAction func chooseEven(_ sender: Any) {
        let isEven = checkOddEven(num: currentNumber)
        updateProgress(num: currentNumber, input: true, output: isEven)
    }
    
    func checkOddEven(num:Int) -> Bool{
        return (num % 2 == 0)
    }
    
    func resetGame(){
        currentNumber = 0
        lastNumber = nil
        myProgress = []
        ivResult.isHidden = true
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
        
    }
}

