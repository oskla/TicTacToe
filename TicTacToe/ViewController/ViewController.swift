//
//  ViewController.swift
//  TicTacToe
//
//  Created by Oskar Larsson on 2022-09-06.
//

import UIKit

class ViewController: UIViewController {

    
    // TODO -
    // SHOW WHO WON - DONE
    // IF THERE'S A TIE - DONE
    // WHEN SOMEONE WINS - YOU SHOULD NOT BE ABLE TO CLICK MORE BOXES - DONE
    
    // VG
    // INPUT NAME FOR PLAYERS - DONE
    // COUNT VICTORIES - DONE BUT CLEAN UP UI
    
    
    
    
    // WHEN GAME IS OVER - BACK TO MENU OR START OVER
    
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
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var lblPlayerTurn: UILabel!
    
    @IBOutlet weak var lblPlayer1Wins: UILabel!
    @IBOutlet weak var lblPlayer2Wins: UILabel!
    
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player1Name: UILabel!
   
    let game = Game(
        player1: Player(image: UIImage(named: "circle")!, isPlaying: true, numberPlayed: 0, playerName: "Kalle1", numbersPlayed: [], numberOfVictories: 0, won: false),
        player2: Player(image: UIImage(named: "cross")!, isPlaying: false, numberPlayed: 0, playerName: "Pelle2", numbersPlayed: [], numberOfVictories: 0, won: false)
        )
    
    var name1: String = ""
    var name2: String = ""
    
    
    var totalNumbersPlayed: Array<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        game.addToArray()
        updateUI()
    }
    
    
    func checkNumberPlayed(inputImage: UIImageView) -> Int {
        switch inputImage {
        case img1: return 1
        case img2: return 2
        case img3: return 3
        case img4: return 4
        case img5: return 5
        case img6: return 6
        case img7: return 7
        case img8: return 8
        case img9: return 9
        default: return 0
        }
        
    }

    
    
//    func setNumberOfVictories() {
//
//        let player1NumberOfVictories = player1.numberOfVictories
//        let player2NumberOfVictories = player2.numberOfVictories
//        lblPlayer1Wins.text = String(player1NumberOfVictories)
//        lblPlayer2Wins.text = String(player2NumberOfVictories)
//    }
        

    func updateUI() {
    
        switchPlayerLbl()
        switchMainLbl()
        
       
        
        guard let gameEnded = game.ended else { return }
           if gameEnded == true {
               game.ended = false
               disableTap()
               
           }
           
        
    }
    

    func switchImage(inputImage: UIImageView) {

        // What image to play
        if game.player1.isPlaying {
            inputImage.image = game.player1.image
            inputImage.isUserInteractionEnabled = false // Can't press same img again
            let player1Number = checkNumberPlayed(inputImage: inputImage) // What number did you press?
            game.player1.numbersPlayed.append(player1Number) // Add played number to array
            game.switchTurn()
            updateUI()
            
        } else if game.player2.isPlaying {
            inputImage.image = game.player2.image
            inputImage.isUserInteractionEnabled = false // Can't press same img again
            let player2Number = checkNumberPlayed(inputImage: inputImage) // What number did you press?
            game.player2.numbersPlayed.append(player2Number) // Add played number to array
            game.switchTurn()
            updateUI()
            
            return
     }
    }
    
    func switchMainLbl() {
        if game.playerWon == game.player1.playerName {
            lblMain.text = "\(game.player1.playerName) won!"
        } else if game.playerWon == game.player2.playerName{
            lblMain.text = "\(game.player2.playerName) won!"
        } else if !game.player1.won || !game.player2.won {
            lblMain.text = "Let's play!"
        }
    }
    
    func switchPlayerLbl() {
       
     print("Checking who won")
       if game.player1.isPlaying {
           lblPlayerTurn.text = "\(game.player1.playerName) turn to play"
       } else {
           lblPlayerTurn.text = "\(game.player2.playerName) turn to play"
       }
        
        if game.player1.won || game.player2.won {
            lblPlayerTurn.text = "Press reset to start new game"
            game.player2.won = false
            game.player1.won = false
        }

   }
    
    @IBAction func onTap1(_ sender: Any) { switchImage(inputImage: img1) }
    @IBAction func onTap2(_ sender: Any) { switchImage(inputImage: img2) }
    @IBAction func onTap3(_ sender: Any) { switchImage(inputImage: img3) }
    @IBAction func onTap4(_ sender: Any) { switchImage(inputImage: img4) }
    @IBAction func onTap5(_ sender: Any) { switchImage(inputImage: img5) }
    @IBAction func onTap6(_ sender: Any) { switchImage(inputImage: img6) }
    @IBAction func onTap7(_ sender: Any) { switchImage(inputImage: img7) }
    @IBAction func onTap8(_ sender: Any) { switchImage(inputImage: img8) }
    @IBAction func onTap9(_ sender: Any) { switchImage(inputImage: img9) }
    
    @IBAction func onReset(_ sender: Any) {
        
        game.player1.numbersPlayed.removeAll()
        game.player2.numbersPlayed.removeAll()
        game.player1.isPlaying = true
        game.player2.isPlaying = false
      
        resetImages()

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
        
        switchMainLbl()
        switchPlayerLbl()
    }
    
    func disableTap() {
      
        img1.isUserInteractionEnabled = false
        img2.isUserInteractionEnabled = false
        img3.isUserInteractionEnabled = false
        img4.isUserInteractionEnabled = false
        img5.isUserInteractionEnabled = false
        img6.isUserInteractionEnabled = false
        img7.isUserInteractionEnabled = false
        img8.isUserInteractionEnabled = false
        img9.isUserInteractionEnabled = false
    }
    }
    


