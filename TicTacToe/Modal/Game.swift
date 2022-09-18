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
    
    func switchTurn() -> Bool {
        if player1.isPlaying == true {
            player1.isPlaying = false
            player2.isPlaying = true
            let checkWinP1 = checkWin(player: &player1)
            checkTie()
            removePossibleNumberLeftToPlay(player: player1)
            print("switching turn from player 1 to player 2")
          return checkWinP1
        } else {
            player1.isPlaying = true
            player2.isPlaying = false
            let checkWinP2 = checkWin(player: &player2)
            checkTie()
            removePossibleNumberLeftToPlay(player: player2)
            print("switching turn from player 2 to player 1")
            return checkWinP2
        }
    }
    
    func computerLastMove(player: inout Player) -> Int {
        for i in 0...7 {
            let checkPlayer1Move = player.numbersPlayed.allSatisfy(winningArrays[i].contains)
            
            if checkPlayer1Move {
                print("--------------------------")
                print("--------------------------")
                print("Check \(player.playerName) move: \(checkPlayer1Move)")
                print("Numbers played: \(player.numbersPlayed)")
                print("WInningArrays: \(winningArrays[i])")
                
                let winningArray = winningArrays[i]
                let numbersPlayed = player.numbersPlayed
                
                let missingNumberArray = winningArray.filter { !numbersPlayed.contains($0) }
                print("Missing number Array: \(missingNumberArray)")
                
                // Add if array is not longer than 1
                var missingNumber = 0
                _ = missingNumberArray.map{ missingNumber = missingNumber + $0 }
                
                print("Missing number: \(missingNumber)")
                
                print("--------------------------")
                print("--------------------------")
                
                player.moveToMake = missingNumber
                
                
                return missingNumber
            }
                
        }
        return 0
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
          //  print(check2)
           // print("Check: \(check)")
           // print(winningArrays[i])
          //  print(player.numbersPlayed)
            if check {
                setNumberOfVictories(player: &player)
                playerWon = player.playerName
                player.won = true
               // print("hej")
                ended = true
               // print("ended: \(ended!)")
                return true
            }
        }
        return false
    }
    
    func removePossibleNumberLeftToPlay(player: Player) {
        //var result = numbersLeftToPlay.remove(at: 0)
      //  print("Number played: \(player.numberPlayed)")
       numbersLeftToPlay = numbersLeftToPlay.filter {$0 != player.numberPlayed}
      //  print("Numbers left to play: \(numbersLeftToPlay)")
        
    }
    
    func checkTie() {
       
        let allNumbersPlayed = [1,2,3,4,5,6,7,8,9]
        totalNumbersPlayed = player1.numbersPlayed + player2.numbersPlayed
        totalNumbersPlayed.sort()
        
        if totalNumbersPlayed == allNumbersPlayed {
            isTie = true
        }
        
    }
    
    func setNumbersLeftToPlay() {
    numbersLeftToPlay = [1,2,3,4,5,6,7,8,9]
    }
    
    func setNumberOfVictories(player: inout Player) {
        player.numberOfVictories += 1
        
    }
    
}
