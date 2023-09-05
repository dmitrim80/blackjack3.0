//
//  BlackJackModel.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/17/23.
//

import Foundation

class BlackJackModel: ObservableObject {
    
    @Published var dealerHand:[String] = []
    @Published var playerHand:[String] = []
    var deck:[String] = ["🂡","🂢","🂣","🂤","🂥","🂦","🂧","🂨","🂩","🂪","🂫","🂭","🂮",
                         "🂱","🂲","🂳","🂴","🂵","🂶","🂷","🂸","🂹","🂺","🂻","🂽","🂾",
                         "🃁","🃂","🃃","🃄","🃅","🃆","🃇","🃈","🃉","🃊","🃋","🃍","🃎",
                         "🃑","🃒","🃓","🃔","🃕","🃖","🃗","🃘","🃙","🃚","🃛","🃝","🃞"]
    var playerScore:Int = 0
    var dealerScore:Int = 0
    var blackJack: Bool = false
    @Published var dealerWin:Bool = false
    @Published var playerWin:Bool = false
    @Published var scoreTied:Bool = false
    var isWinner:Bool = false
    var dealerWinBust:Bool = false
    var playerWinBust:Bool = false
    var hitCount:Int = 0
    @Published var numPlayerWins:Int = 0
    @Published var numDealerWins:Int = 0
    var holdPressed:Bool = false
    let cardValue:[String:Int] = [
        "🂡":0,"🂢":2,"🂣":3,"🂤":4,"🂥":5,"🂦":6,"🂧":7,"🂨":8,"🂩":9,"🂪":10,"🂫":10,"🂭":10,"🂮":10,
        "🂱":0,"🂲":2,"🂳":3,"🂴":4,"🂵":5,"🂶":6,"🂷":7,"🂸":8,"🂹":9,"🂺":10,"🂻":10,"🂽":10,"🂾":10,
        "🃁":0,"🃂":2,"🃃":3,"🃄":4,"🃅":5,"🃆":6,"🃇":7,"🃈":8,"🃉":9,"🃊":10,"🃋":10,"🃍":10,"🃎":10,
        "🃑":0,"🃒":2,"🃓":3,"🃔":4,"🃕":5,"🃖":6,"🃗":7,"🃘":8,"🃙":9,"🃚":10,"🃛":10,"🃝":10,"🃞":10]
    
    func startNewGame() {
        self.deck = ["🂡","🂢","🂣","🂤","🂥","🂦","🂧","🂨","🂩","🂪","🂫","🂭","🂮",
                              "🂱","🂲","🂳","🂴","🂵","🂶","🂷","🂸","🂹","🂺","🂻","🂽","🂾",
                              "🃁","🃂","🃃","🃄","🃅","🃆","🃇","🃈","🃉","🃊","🃋","🃍","🃎",
                              "🃑","🃒","🃓","🃔","🃕","🃖","🃗","🃘","🃙","🃚","🃛","🃝","🃞"]
        self.deck.shuffle()
        self.holdPressed = false
        self.playerHand.removeAll()
        self.dealerHand.removeAll()
        self.dealerWinBust = false
        self.playerWinBust = false
        self.dealerWin = false
        self.playerWin = false
        self.scoreTied = false
        self.isWinner = false
        self.hitCount = 0
        self.blackJack = false
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
    
    func drawCard () {
        self.playerHand.append(self.deck.removeLast())
    }
    
    func checkWinner() {
        if isWinner == true {
            return
        } else if playerScore == 21 && playerHand.count == 2 && dealerScore < 21 {
            // blackjack player, player wins
            blackJack = true
            playerWin = true
            numPlayerWins += 1
            isWinner = true
        } else if dealerScore == 21 && dealerHand.count == 2 && playerScore < 21 {
            // blackjack dealer, dealer wins
            blackJack = true
            dealerWin = true
            numDealerWins += 1
            isWinner = true
            // 2 blackjacks tie
        } else if playerScore == 21 && dealerScore == 21 && playerHand.count == 2 && dealerHand.count == 2{
            scoreTied = true
            isWinner = true
        } else if playerScore > 21 {
            // player bust, dealer wins
            dealerWinBust = true
            isWinner = true
            numDealerWins += 1
        } else if dealerScore > 21 && playerScore <= 21  {
            // dealer bust, player wins
            playerWinBust = true
            isWinner = true
            numPlayerWins += 1
        } else if dealerScore <= 21 && dealerScore > playerScore && holdPressed == true {
            dealerWin = true
            isWinner = true
            numDealerWins += 1
        } else if dealerScore == playerScore && holdPressed == true {
            scoreTied = true
            isWinner = true
        }
    }
    
    func dealerTurn() {
        var timer = Timer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
               if self.dealerScore < 21 && self.playerScore > self.dealerScore {
                   self.dealerHand.append(self.deck.removeLast())
                   self.dealerScore = self.calculateHandValue(hand: self.dealerHand)
                   self.checkWinner()
               } else {
                   timer.invalidate()
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
}







