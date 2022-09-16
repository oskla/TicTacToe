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
       // makeMove(player: &player1)
        addToArray()
    }

    func addToArray() {
        winningArrays = [win1,win2,win3,win4,win5,win6,win7,win8]
    }
    
//    func makeMove(player: inout Player) {
//        if player.isPlaying == true {
//
//            print("Move made by \(player.playerName)")
//            checkWin(player: player)
//           // checkTie()
//
//        } else {
//
//            print("Move made by \(player.playerName)")
//            checkWin(player: player)
//        //    checkTie()
//
//
//        }
//    }
    
    func switchTurn()  {
        
       
        
        if player1.isPlaying == true {
            player1.isPlaying = false
            player2.isPlaying = true
            //makeMove(player: &player1)
            
          
            checkWin(player: &player1)
          
            print("switching turn from player 1 to player 2")
          return
        } else {
            player1.isPlaying = true
            player2.isPlaying = false
           // makeMove(player: &player2)
        
            checkWin(player: &player2)
         
            print("switching turn from player 2 to player 1")
            
        }
        return
    }
    
    func checkWin(player: inout Player) {
        for i in 0...7 {
            if winningArrays[i].allSatisfy(player.numbersPlayed.contains) {
                print("Victory for \(player.playerName)")
                //setNumberOfVictories(player: player)
                print("setting \(player.playerName) as winner")
                playerWon = player.playerName
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
            print("it's a tie!!")
        }
        
    }
    
    func setNumberOfVictories(player: Player) {
  
//        if player.playerName == player1.playerName {
//            player1.numberOfVictories += 1
//        } else if player.playerName == player2.playerName {
//            player2.numberOfVictories += 1
//        }
//
//        switch playerNumber {
//        case 1:
//            self.player1.numberOfVictories += 1
//        case 2:
//            self.player2.numberOfVictories += 2
//        default: return
//        }
        
        
//        print("\(player) has won \(result) times")
    }
    
}
