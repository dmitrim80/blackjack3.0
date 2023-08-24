//
//  BlackJackModel.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/17/23.
//

import Foundation

struct BlackJackModel {
    
    var dealerHand:[String] = []
    var playerHand:[String] = []
    var deck:[String] = ["🂡","🂢","🂣","🂤","🂥","🂦","🂧","🂨","🂩","🂪","🂫","🂭","🂮",
                         "🂱","🂲","🂳","🂴","🂵","🂶","🂷","🂸","🂹","🂺","🂻","🂽","🂾",
                         "🃁","🃂","🃃","🃄","🃅","🃆","🃇","🃈","🃉","🃊","🃋","🃍","🃎",
                         "🃑","🃒","🃓","🃔","🃕","🃖","🃗","🃘","🃙","🃚","🃛","🃝","🃞"]
    var playerScore:Int = 0
    var dealerScore:Int = 0
    var blackJack: Bool = false
    var dealerWin:Bool = false
    var playerWin:Bool = false
    var scoreTied:Bool = false
    var isWinner:Bool = false
    var dealerWinBust:Bool = false
    var playerWinBust:Bool = false
    var hitCount:Int = 0
    let cardValue:[String:Int] = [
        "🂡":0,"🂢":2,"🂣":3,"🂤":4,"🂥":5,"🂦":6,"🂧":7,"🂨":8,"🂩":9,"🂪":10,"🂫":10,"🂭":10,"🂮":10,
        "🂱":0,"🂲":2,"🂳":3,"🂴":4,"🂵":5,"🂶":6,"🂷":7,"🂸":8,"🂹":9,"🂺":10,"🂻":10,"🂽":10,"🂾":10,
        "🃁":0,"🃂":2,"🃃":3,"🃄":4,"🃅":5,"🃆":6,"🃇":7,"🃈":8,"🃉":9,"🃊":10,"🃋":10,"🃍":10,"🃎":10,
        "🃑":0,"🃒":2,"🃓":3,"🃔":4,"🃕":5,"🃖":6,"🃗":7,"🃘":8,"🃙":9,"🃚":10,"🃛":10,"🃝":10,"🃞":10
    ]
    
    mutating func startNewGame() {
        self.dealerWinBust = false
        self.playerWinBust = false
        self.dealerWin = false
        self.playerWin = false
        self.scoreTied = false
        self.isWinner = false
        self.hitCount = 0
        self.blackJack = false
        self.playerHand.removeAll()
        self.dealerHand.removeAll()
        self.deck.shuffle()
        self.playerHand.append(self.deck.removeLast())
        self.dealerHand.append(self.deck.removeLast())
        self.playerHand.append(self.deck.removeLast())
        self.dealerHand.append(self.deck.removeLast())
        dealerScore = calculateHandValue(hand: self.dealerHand)
        playerScore = calculateHandValue(hand: self.playerHand)
        checkWinner()
    }
    
    func calculateHandValue(hand: [String]) -> Int {
        var score = 0
        var ace = 0
        for card in hand {
            if card == "🂡" || card == "🂱" || card == "🃁" || card == "🃑" {
                ace += 1
            }
            if let cardValue = cardValue[card] {
                score += cardValue
            }
        }
        if ace > 0 {
            score += getRightAce(currentScore: score, numAces: ace)
        }
        return score
    }
    
    mutating func getResult() {
        if playerScore > dealerScore && playerScore <= 21 {
            playerWin = true
            isWinner = true
        } else if playerScore == dealerScore && playerScore <= 21 {
            scoreTied = true
            isWinner = true
        } else if dealerScore > playerScore && dealerScore <= 21 {
            dealerWin = true
            isWinner = true
        } else if playerScore > 21 {
             dealerWinBust = true
            isWinner = true
        } else if dealerScore > 21 {
            playerWinBust = true
            isWinner = true
        }
    }
    
    mutating func drawCard () {
        self.playerHand.append(self.deck.removeLast())
    }
    
    mutating func checkWinner() {
        if playerScore > 21 {
            dealerWinBust = true
            isWinner = true
        } else if dealerScore > 21 {
            playerWinBust = true
            isWinner = true
        } else if playerScore == 21 && playerHand.count == 2 && dealerScore < 21 {
            blackJack = true
            playerWin = true
            isWinner = true
        }   else if dealerScore == 21 && dealerHand.count == 2 && playerScore < 21 {
                blackJack = true
                dealerWin = true
                isWinner = true
        }
        else if dealerScore == 21 && playerScore < 21 {
            dealerWin = true
            isWinner = true
        } else if dealerScore == 21 && playerScore == 21 && playerHand.count == 2 {
            blackJack = true
            scoreTied = true
            isWinner = true
        }
    }
    
    mutating func dealerTurn() {
        while dealerScore < 21 && playerScore > dealerScore {
        self.dealerHand.append(self.deck.removeLast())
        dealerScore = calculateHandValue(hand: dealerHand)
        checkWinner()
        }
    }
}

func getRightAce(currentScore: Int, numAces:Int) -> Int {
    let delta = 21 - currentScore
    let elevanAce = 11 + (numAces - 1)
    if elevanAce <= delta {
        return elevanAce
    }
    return numAces
}





