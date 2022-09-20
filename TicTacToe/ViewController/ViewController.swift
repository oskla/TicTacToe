//
//  ViewController.swift
//  TicTacToe
//
//  Created by Oskar Larsson on 2022-09-06.
//

import UIKit

class ViewController: UIViewController {

    
    // TODO - make player2 a little smarter. For example if played [1,5,8]. Recognize that [2,5,8] is closest win (if 2 is not taken)
    
    // fix UI for login so you can pick 1p or 2p
    
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
    
    @IBOutlet weak var lblPlayer2Name: UILabel!
    @IBOutlet weak var lblPlayer1Name: UILabel!
   
    let game = Game(
        player1: Player(image: UIImage(named: "circle")!, isPlaying: true, numberPlayed: 0, playerName: "Kalle1", numbersPlayed: [], numberOfVictories: 0, won: false, isComputer: false),
        player2: Player(image: UIImage(named: "cross")!, isPlaying: false, numberPlayed: 0, playerName: "Pelle2", numbersPlayed: [], numberOfVictories: 0, won: false, isComputer: true)
        )
    
    var name1: String = "Kalle1"
    var name2: String = "Pelle2"
    var isComputer: Bool = false
    
    var totalNumbersPlayed: Array<Int> = []
    
    var someOneWon = false
    var isTie = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setPlayerNames()
        isPlayerComputer()
        game.addToArray()
        updateUI()
      //  makeRandomMove()
    }

    
    

    
    func makeComputerMove() {
        

        
        if game.player2.isComputer && !someOneWon && !isTie {
            let moveToMakeIfP1HasTwoInARow = game.whatNumberToPlay(player: &game.player1)
            let moveToMakeIfP2HasTwoInARow = game.whatNumberToPlay(player: &game.player2)
            let randomElement = game.getRandomNumber()
            
            // Check if array 
            if game.checkNumberSize(number: moveToMakeIfP2HasTwoInARow) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                    switchImage(inputImage: self.numberToImageView(inputNumber: moveToMakeIfP2HasTwoInARow))
                    print("player2 has two in a row\(moveToMakeIfP2HasTwoInARow)")
                }
                return
            } else if game.checkNumberSize(number: moveToMakeIfP1HasTwoInARow) {
                // Call performTask after a delay of 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                    switchImage(inputImage: self.numberToImageView(inputNumber: moveToMakeIfP1HasTwoInARow))
                    print("player1 has two in a row\(moveToMakeIfP1HasTwoInARow)")
                }
            } else {
                // Call performTask after a delay of 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                    switchImage(inputImage: self.numberToImageView(inputNumber: randomElement))
                    print("playing random: \(randomElement)")
                }
            }
        }
        
    }
    
    func numberToImageView(inputNumber: Int) -> UIImageView {
        switch inputNumber {
        case 1: return img1
        case 2: return img2
        case 3: return img3
        case 4: return img4
        case 5: return img5
        case 6: return img6
        case 7: return img7
        case 8: return img8
        case 9: return img9
        default:
            return img1
        }
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
        
    func setPlayerNames() {
        game.player1.playerName = name1
        game.player2.playerName = name2
    }

    func updateUI() {
        setPlayerLbl()
        setMainLbl()
        setVictoriesLbl()
        
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
            
            game.player1.numberPlayed = player1Number // Set last played number
            game.player1.numbersPlayed.append(player1Number) // Add played number to array
            
            let checkSwitchTurn = game.switchTurn()
            let checkWin = checkSwitchTurn.0
            let checkTie = checkSwitchTurn.1
            
            someOneWon = checkWin
            isTie = checkTie
            updateUI()
            makeComputerMove()
            return
            
            
        } else if game.player2.isPlaying {
            
            inputImage.image = game.player2.image
            inputImage.isUserInteractionEnabled = false // Can't press same img again
            let player2Number = checkNumberPlayed(inputImage: inputImage) // What number did you press?
            
            game.player2.numberPlayed = player2Number // Set last played number
            game.player2.numbersPlayed.append(player2Number) // Add played number to array
            
            let checkSwitchTurn = game.switchTurn()
            let checkWin = checkSwitchTurn.0 // Return value for checkWin
            let checkTie = checkSwitchTurn.1 // Return value for checkTie
            
            someOneWon = checkWin
            isTie = checkTie
            updateUI()
            
            return
     }
    }
    
    func setMainLbl() {
        
        
        if game.playerWon == game.player1.playerName {
            lblMain.text = "\(game.player1.playerName) won!"
        } else if game.playerWon == game.player2.playerName{
            lblMain.text = "\(game.player2.playerName) won!"
        }
        
        if !someOneWon {
            lblMain.text = "Let's play!"
        }
        
        if game.isTie ?? false && !someOneWon {
            lblMain.text = "It's a tie!"
            game.isTie = false
        }
    }
    
    func setVictoriesLbl() {
        lblPlayer1Wins.text = String(game.player1.numberOfVictories)
        lblPlayer2Wins.text = String(game.player2.numberOfVictories)
        lblPlayer1Name.text = game.player1.playerName
        lblPlayer2Name.text = game.player2.playerName

    }
    
    func setPlayerLbl() {
       if game.player1.isPlaying {
           lblPlayerTurn.text = "\(game.player1.playerName) turn to play"
       } else {
           lblPlayerTurn.text = "\(game.player2.playerName) turn to play"
       }
        
        if game.player1.won || game.player2.won || game.isTie ?? false {
            lblPlayerTurn.text = "Press reset to start new game"
            game.player2.won = false
            game.player1.won = false
        }
   }
    
    func isPlayerComputer() {
        if isComputer {
            game.player2.isComputer = true
        } else {
            game.player2.isComputer = false
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
        someOneWon = false
        game.player1.isPlaying = true
        game.player2.isPlaying = false
        game.player1.won = false
        game.player2.won = false
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
        
        setMainLbl()
        setPlayerLbl()
        game.setNumbersLeftToPlay()
        
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
    


