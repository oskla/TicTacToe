//
//  Game.swift
//  TicTacToe
//
//  Created by Oskar Larsson on 2022-09-11.
//

import Foundation
import UIKit



class Game {

   
    var winningArrays = [[Int]]()
    
    var player1: Player
    var player2: Player
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    var playerWon: String?
    var ended: Bool?
    var isTie: Bool?
    var totalNumbersPlayed: Array<Int> = []
    var numbersLeftToPlay: Array<Int> = [1,2,3,4,5,6,7,8,9]
 //   var currentGameStatus = STATUS_GAME_INACTIVE
    
    //Numbers that will lead to victory
    let win1 = [3, 5, 7]
    let win2 = [1, 5, 9]
    let win3 = [1, 4, 7]
    let win4 = [2, 5, 8]
    let win5 = [3, 6, 9]
    let win6 = [1, 2, 3]
    let win7 = [4, 5, 6]
    let win8 = [7, 8, 9]
    
    func startGame() -> Bool {
        if player2.isComputer {
            return true
        }
        return false
    }

    func addToArray() {
        winningArrays = [win1,win2,win3,win4,win5,win6,win7,win8]
    }
    
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
    
    func whatNumberToPlay(player: inout Player) -> Int {
    //    goForTheWin(player: &player)
        for i in 0...7 {
            
            // Check if played number appears in any of the winningArrays
            let checkPlayer1Move = player.numbersPlayed.allSatisfy(winningArrays[i].contains)

            //If true ->
            if checkPlayer1Move {
                
                let winningArray = winningArrays[i]
                let numbersPlayed = player.numbersPlayed
                var missingNumber = "0"
                
                // Get missing number from winningArray
                let missingNumberArray = winningArray.filter { numbersPlayed.contains($0) == false }
                print("----------")
                print(" \(player.playerName) Numbers played: \(numbersPlayed)")
                print(" \(player.playerName) identified winning array: \(winningArray)")
                print(" \(player.playerName) Missing Number array: \(missingNumberArray)")
                print("----------")

                
                // add citation to every mapped element
                _ = missingNumberArray.map{ missingNumber = missingNumber + "\($0)" }
               
                //Transform array into Int
                let missingNumberInt: Int = Int(missingNumber)!
                
                // Check if number is possible to play
                let isItAvailable = checkNumberAvailable(numberPlayed: missingNumberInt)
                
                if isItAvailable {
                    return missingNumberInt
                }
                
                return 0
            }
                
        }
        return 0
    }
    
    
    func secondRound(player: inout Player) -> Int {
    //    goForTheWin(player: &player)
        for i in 0...7 {
            
            // Check if played number appears in any of the winningArrays
            let checkPlayer1Move = player.numbersPlayed.allSatisfy(winningArrays[i].contains)

            //If true ->
            if checkPlayer1Move {
                
                let winningArray = winningArrays[i]
                let numbersPlayed = player.numbersPlayed
                let missingNumber = "0"
                
                // Get missing number from winningArray
                let missingNumberArray = numbersPlayed.filter { winningArray.contains($0) == false }
                print("----------")
                print(" \(player.playerName) Numbers played: \(numbersPlayed)")
                print(" \(player.playerName) Missing Number array: \(missingNumberArray)")
                print("----------")
                
           
                
                // Check if number is possible to play
              //  let isItAvailable = checkNumberAvailable(numberPlayed: missingNumberInt)
                
//                if isItAvailable {
//                    return 0 //missingNumberInt
//                }
                
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
       
     //  let moveToMake = computerLastMove(player: &player)
        for i in 0...7 {
            
          //  let check2 = player.numbersPlayed.allSatisfy(winningArrays[i].contains)
            let check = winningArrays[i].allSatisfy(player.numbersPlayed.contains)
            if check {
                setNumberOfVictories(player: &player)
                playerWon = player.playerName
                player.won = true
                ended = true
                print("Win!!")
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
            print("Tie!!")
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
    
}
