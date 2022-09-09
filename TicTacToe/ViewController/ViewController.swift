//
//  ViewController.swift
//  TicTacToe
//
//  Created by Oskar Larsson on 2022-09-06.
//

import UIKit

class ViewController: UIViewController {

    
    // TODO -
    // SHOW WHO WON
    // CLEAN UP
    // IF THERE'S A TIE
    // WHEN GAME IS OVER - BACK TO MENU OR START OVER
    // WHEN SOMEONE WINS - YOU SHOULD NOT BE ABLE TO CLICK MORE BOXES
    
    // VG
    // INPUT NAME FOR PLAYERS - line 64
    // COUNT VICTORIES
    // SEPARATE LOGIC FROM CONTROLLER
    // PLAY AGAINST COMPUTER (RANDOM)
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    @IBOutlet weak var img9: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var name1: String
    var name2: String
    
    var passed: Bool
    
    var player1 = Player(image: UIImage(named: "circle")!, isPlaying: true, numberPlayed: 0, numbersPlayed: [])
    var player2 = Player(image: UIImage(named: "cross")!, isPlaying: false, numberPlayed: 0, numbersPlayed: [])
    
 
    // Array of arrays of winning numbers
    var winningArrays = [[Int]]()
    
    //Numbers that will lead to victory
    let win1 = [3, 5, 7]
    let win2 = [1, 5, 9]
    let win3 = [1, 4, 7]
    let win4 = [2, 5, 8]
    let win5 = [3, 6, 9]
    let win6 = [1, 2, 3]
    let win7 = [4, 5, 6]
    let win8 = [7, 8, 9]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SEND STUFF
        
//        if passed {
//            textLabel.text = "Player 1's turn"
//        }
        
       // textLabel.text = "Game on!"
        addToArray()
        
    }
    
   
    
    // Add winning numbercombinations to array
    func addToArray() {
        winningArrays = [win1,win2,win3,win4,win5,win6,win7,win8]
    }
    
    func checkNumberPlayed(inputImage: UIImageView) -> Int {
        switch inputImage {
        case img1:
            return 1
        case img2:
            return 2
        case img3:
            return 3
        case img4:
            return 4
        case img5:
            return 5
        case img6:
            return 6
        case img7:
            return 7
        case img8:
            return 8
        case img9:
            return 9
        default: return 0
        }
        
    }
    
    func checkWin(player: Player){
        for i in 0...7 {
            if winningArrays[i].allSatisfy(player.numbersPlayed.contains) {
                textLabel.text = "That's three in a row!"
                print("\(winningArrays[i]) got lucky!")
                return
            }
        }
        
    }
    

    func switchImage(inputImage: UIImageView) {

        // What image to play
        if player1.isPlaying {
            inputImage.image = player1.image
            inputImage.isUserInteractionEnabled = false // Can't press same img again
            let player1Number = checkNumberPlayed(inputImage: inputImage) // What number did you press?
            player1.numbersPlayed.append(player1Number) // Add played number to array
            
            switchTurn()
        } else {
            inputImage.image = player2.image
            inputImage.isUserInteractionEnabled = false // Can't press same img again
            
            let player2Number = checkNumberPlayed(inputImage: inputImage) // What number did you press?
            player2.numbersPlayed.append(player2Number) // Add played number to array
            switchTurn()
        }
    }
    
    func switchTurn() {

        if player1.isPlaying {
            player1.isPlaying = false
            player2.isPlaying = true
            checkWin(player: player1)
            print(player1.numbersPlayed)
            return
        }
        
        if player2.isPlaying {
            player1.isPlaying = true
            player2.isPlaying = false
            
            print(player2.numbersPlayed)
            checkWin(player: player2)
            return
        }
        
    }
    

    @IBAction func onTap1(_ sender: Any) {
    switchImage(inputImage: img1)

    }
    
    @IBAction func onTap2(_ sender: Any) {
        switchImage(inputImage: img2)
        
    }
    
    @IBAction func onTap3(_ sender: Any) {
        switchImage(inputImage: img3)
       
    }
    
    @IBAction func onTap4(_ sender: Any) {
        switchImage(inputImage: img4)
       
    }
    
    @IBAction func onTap5(_ sender: Any) {
        switchImage(inputImage: img5)
        
    }
    @IBAction func onTap6(_ sender: Any) {
        switchImage(inputImage: img6)
        
    }
    @IBAction func onTap7(_ sender: Any) {
        switchImage(inputImage: img7)
        
    }
    @IBAction func onTap8(_ sender: Any) {
        switchImage(inputImage: img8)
        
    }
    @IBAction func onTap9(_ sender: Any) {
        switchImage(inputImage: img9)
    }
    @IBAction func onReset(_ sender: Any) {
        
        player1.numbersPlayed.removeAll()
        player2.numbersPlayed.removeAll()
        player1.isPlaying = true
        player2.isPlaying = false
        
        resetImages()
   
        textLabel.text = "Game on!"

    }
    
    func resetImages() {
        img1.image = UIImage(named: "box")
        img2.image = UIImage(named: "box")
        img3.image = UIImage(named: "box")
        img4.image = UIImage(named: "box")
        img5.image = UIImage(named: "box")
        img6.image = UIImage(named: "box")
        img7.image = UIImage(named: "box")
        img8.image = UIImage(named: "box")
        img9.image = UIImage(named: "box")
        
        img1.isUserInteractionEnabled = true
        img2.isUserInteractionEnabled = true
        img3.isUserInteractionEnabled = true
        img4.isUserInteractionEnabled = true
        img5.isUserInteractionEnabled = true
        img6.isUserInteractionEnabled = true
        img7.isUserInteractionEnabled = true
        img8.isUserInteractionEnabled = true
        img9.isUserInteractionEnabled = true
    }
    }
    


