//
//  BlackJackModel.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/17/23.
//

import Foundation

class BlackJackModel: ObservableObject {
    @Published var gameStart: Bool = false
    @Published var isWinner: Bool = false
    @Published var hide2ndCard: Bool = true
    @Published var bet:Float = 0
    @Published var previousBet:Float = 0
    @Published var playerMoney: Float = 1_000
    @Published var placeBetMessage = "Place your bet"
    @Published var betMessage = "Your bet: $"
    @Published var dealerHand:[String] = []
    @Published var playerHand:[String] = []
    @Published var deck:[String] = [
                        "🂡","🂢","🂣","🂤","🂥","🂦","🂧","🂨","🂩","🂪","🂫","🂭","🂮",
                        "🂱","🂲","🂳","🂴","🂵","🂶","🂷","🂸","🂹","🂺","🂻","🂽","🂾",
                        "🃁","🃂","🃃","🃄","🃅","🃆","🃇","🃈","🃉","🃊","🃋","🃍","🃎",
                        "🃑","🃒","🃓","🃔","🃕","🃖","🃗","🃘","🃙","🃚","🃛","🃝","🃞"]
    @Published var playerScore:Int = 0
    @Published var dealerScore:Int = 0
    @Published var blackJack: Bool = false
    @Published var dealerWin:Bool = false
    @Published var playerWin:Bool = false
    @Published var scoreTied:Bool = false
    @Published var dealerWinBust:Bool = false
    @Published var playerWinBust:Bool = false
    @Published var hitCount:Int = 0
    @Published var numPlayerWins:Int = 0
    @Published var numDealerWins:Int = 0
    @Published var numTiedGames:Int = 0
    @Published var holdPressed:Bool = false
    
    let cardValue:[String:Int] = [
        "🂡":0,"🂢":2,"🂣":3,"🂤":4,"🂥":5,"🂦":6,"🂧":7,"🂨":8,"🂩":9,"🂪":10,"🂫":10,"🂭":10,"🂮":10,
        "🂱":0,"🂲":2,"🂳":3,"🂴":4,"🂵":5,"🂶":6,"🂷":7,"🂸":8,"🂹":9,"🂺":10,"🂻":10,"🂽":10,"🂾":10,
        "🃁":0,"🃂":2,"🃃":3,"🃄":4,"🃅":5,"🃆":6,"🃇":7,"🃈":8,"🃉":9,"🃊":10,"🃋":10,"🃍":10,"🃎":10,
        "🃑":0,"🃒":2,"🃓":3,"🃔":4,"🃕":5,"🃖":6,"🃗":7,"🃘":8,"🃙":9,"🃚":10,"🃛":10,"🃝":10,"🃞":10]
    
    func startNewGame() {
        if bet > 0 {
            self.deck = ["🂡","🂢","🂣","🂤","🂥","🂦","🂧","🂨","🂩","🂪","🂫","🂭","🂮",
                         "🂱","🂲","🂳","🂴","🂵","🂶","🂷","🂸","🂹","🂺","🂻","🂽","🂾",
                         "🃁","🃂","🃃","🃄","🃅","🃆","🃇","🃈","🃉","🃊","🃋","🃍","🃎",
                         "🃑","🃒","🃓","🃔","🃕","🃖","🃗","🃘","🃙","🃚","🃛","🃝","🃞"]
            self.deck.shuffle()
            self.holdPressed = false
            self.playerHand.removeAll()
            self.dealerHand.removeAll()
            self.playerScore = 0
            self.dealerScore = 0
            self.dealerWinBust = false
            self.playerWinBust = false
            self.dealerWin = false
            self.playerWin = false
            self.scoreTied = false
            self.isWinner = false
            self.hitCount = 0
            self.blackJack = false
            self.betMessage = "Your bet: $"
            self.playerHand.append(self.deck.removeLast())
            self.dealerHand.append(self.deck.removeLast())
            self.playerHand.append(self.deck.removeLast())
            self.dealerHand.append(self.deck.removeLast())
            dealerScore = calculateHandValue(hand: self.dealerHand)
            playerScore = calculateHandValue(hand: self.playerHand)
            checkWinner()
        }
    }
    
    func hitOrDeal() {
        if gameStart {
            drawCard()
            hitCount += 1
            playerScore = calculateHandValue(hand: playerHand)
            checkWinner()
            if isWinner {
                hide2ndCard = false
            }
        }
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
    
    func calculateBet() {
        if playerWin && blackJack {
            playerMoney = playerMoney + bet * 1.5
            bet = 0
        } else if playerWin {
            playerMoney = playerMoney + bet
            bet = 0
        } else if dealerWin {
            playerMoney -= bet
            bet = 0
        }
    }
    
    func checkWinner() {
        // returning inition winner so that cards can be displayed
        if isWinner {
            return
        }
        else if playerScore == 21 && playerHand.count == 2 && dealerScore < 21 {
            // blackjack player, player wins
            blackJack = true
            playerWin = true
            isWinner = true
            numPlayerWins += 1
            gameStart = false
        } else if dealerScore == 21 && dealerHand.count == 2 && playerScore < 21 {
            // blackjack dealer, dealer wins
            blackJack = true
            dealerWin = true
            numDealerWins += 1
            isWinner = true
            gameStart = false
        } else if playerScore == 21 && dealerScore == 21 && playerHand.count == 2 && dealerHand.count == 2{
            // 2 blackjacks tied
            scoreTied = true
            isWinner = true
            numTiedGames += 1
            gameStart = false
        } else if playerScore > 21 {
            // player bust, dealer wins
            dealerWin = true
            dealerWinBust = true
            isWinner = true
            numDealerWins += 1
            gameStart = false
        } else if dealerScore > 21 && playerScore <= 21  {
            // dealer bust, player wins
            playerWin = true
            playerWinBust = true
            isWinner = true
            numPlayerWins += 1
            gameStart = false
        } else if dealerScore <= 21 && dealerScore > playerScore && holdPressed == true {
            dealerWin = true
            isWinner = true
            numDealerWins += 1
            gameStart = false
        } else if dealerScore == playerScore && holdPressed == true {
            scoreTied = true
            isWinner = true
            numTiedGames += 1
            gameStart = false
        }
        calculateBet()
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







