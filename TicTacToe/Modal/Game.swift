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
    
    func startGame() {
        addToArray()
    }

    func addToArray() {
        winningArrays = [win1,win2,win3,win4,win5,win6,win7,win8]
    }
    
    func switchTurn()  {
        if player1.isPlaying == true {
            player1.isPlaying = false
            player2.isPlaying = true
            checkWin(player: &player1)
            checkTie()
          
            print("switching turn from player 1 to player 2")
          return
        } else {
            player1.isPlaying = true
            player2.isPlaying = false

            checkWin(player: &player2)
            checkTie()
            print("switching turn from player 2 to player 1")
            
        }
        return
    }
    
    func checkWin(player: inout Player) {
        for i in 0...7 {
            if winningArrays[i].allSatisfy(player.numbersPlayed.contains) {
                setNumberOfVictories(player: &player)
                playerWon = player.playerName
                player.won = true
                ended = true
                return
            }
        }
        return
    }
    
    func checkTie() {
       
        let allNumbersPlayed = [1,2,3,4,5,6,7,8,9]
        totalNumbersPlayed = player1.numbersPlayed + player2.numbersPlayed
        totalNumbersPlayed.sort()
        
        if totalNumbersPlayed == allNumbersPlayed {
            isTie = true
        }
        
    }
    
    func setNumberOfVictories(player: inout Player) {
  
        player.numberOfVictories += 1
        
        
    }
    
}
