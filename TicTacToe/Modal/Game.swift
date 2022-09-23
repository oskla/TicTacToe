//
//  Game.swift
//  TicTacToe
//
//  Created by Oskar Larsson on 2022-09-11.
//

import Foundation
import UIKit



class Game {

   
    var winningArrays =
        [[3, 5, 7],
        [1, 5, 9],
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9],
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]]
    
    var player1: Player
    var player2: Player
    
    var theWinningArray1: Array<Int> = []
    var theWinningArray2: Array<Int> = []
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    var playerWon: String?
    var ended: Bool?
    var isTie: Bool?
    var totalNumbersPlayed: Array<Int> = []
    var numbersLeftToPlay: Array<Int> = [1,2,3,4,5,6,7,8,9]

    
    func switchTurn() -> (Bool, Bool) {
        if player1.isPlaying == true {
            player1.isPlaying = false
            player2.isPlaying = true
            let checkWinP1 = checkWin(player: &player1)
            let checkTie = checkTie()
            removePossibleNumberLeftToPlay(player: player1)
            print("switching turn from player 1 to player 2")
          return (checkWinP1, checkTie)
        } else {
            player1.isPlaying = true
            player2.isPlaying = false
            let checkWinP2 = checkWin(player: &player2)
            let checkTie = checkTie()
            removePossibleNumberLeftToPlay(player: player2)
            print("switching turn from player 2 to player 1")
            return (checkWinP2, checkTie)
        }
    }
    
    // Computer move
    func whatNumberToPlay(player: inout Player) -> Int {
        var missingNumberArray: Array<Int> = []
        
        for i in 0...(winningArrays.count - 1) {
            
            // Check if played number appears in any of the winningArrays
            let checkPlayerMove = player.numbersPlayed.allSatisfy(winningArrays[i].contains)

            //If true ->
            if checkPlayerMove {
                
                let winningArray = winningArrays[i]
                let numbersPlayed = player.numbersPlayed
                var missingNumber = "0"
                
                missingNumberArray = winningArray.filter { numbersPlayed.contains($0) == false } // Get missing number from winningArray
                _ = missingNumberArray.map{ missingNumber = missingNumber + "\($0)" } // add citation to every mapped element
                let missingNumberInt: Int = Int(missingNumber)! //Transform array into Int
                let isItAvailable = checkNumberAvailable(numberPlayed: missingNumberInt) // Check if number is possible to play
                
                if isItAvailable {
                    return missingNumberInt
                    
                }
                return 0
            }
        }
        return 0
    }
    
    
    func checkNumberAvailable(numberPlayed: Int) -> Bool {
        let isNumberAvailable = numbersLeftToPlay.contains(numberPlayed)
        if isNumberAvailable {
            return true
        }
        return false
    }

    
    
    func checkNumberSize(number: Int) -> Bool {
        if number > 0 && number < 10 {
            return true
        }
        return false
    }
    
    func getRandomNumber() -> Int {
        if let randomNumber = numbersLeftToPlay.randomElement() {
            return randomNumber
        }
    return 0
    }
    
    func checkWin(player: inout Player) -> Bool {
        for i in 0...7 {
            
            // Compare numbersPlayed array with winningArrays to see if there's a match
            let check = winningArrays[i].allSatisfy(player.numbersPlayed.contains)
            if check {
                setNumberOfVictories(player: &player)
                playerWon = player.playerName
                player.won = true
                ended = true
                return true
            }
        }
        return false
    }
    
    func removePossibleNumberLeftToPlay(player: Player) {
       numbersLeftToPlay = numbersLeftToPlay.filter {$0 != player.numberPlayed}
        
    }
    
    func checkTie() -> Bool {
       
        let allNumbersPlayed = [1,2,3,4,5,6,7,8,9]
        totalNumbersPlayed = player1.numbersPlayed + player2.numbersPlayed
        totalNumbersPlayed.sort()
        
        if totalNumbersPlayed == allNumbersPlayed {
            isTie = true
            return true
        }
        return false
    }
    
    func setNumbersLeftToPlay() {
    numbersLeftToPlay = [1,2,3,4,5,6,7,8,9]
    }
    
    func setNumberOfVictories(player: inout Player) {
        player.numberOfVictories += 1
        
    }
    
    func returnWinningArray() -> Array<Int> {return theWinningArray1}
    
}
