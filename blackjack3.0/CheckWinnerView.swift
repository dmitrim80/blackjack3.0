//
//  CheckWinnerView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 9/7/23.
//

import SwiftUI

struct CheckWinnerView: View {
    @EnvironmentObject var blackjackModel: BlackJackModel
    var body: some View {
        if blackjackModel.scoreTied && blackjackModel.holdPressed {
            HStack{
            Text("PUSH!\n Both Score:\(blackjackModel.playerScore)")
                    }
            .onAppear {
                //added to see if it will work last
                blackjackModel.bet = 0
                blackjackModel.hide2ndCard = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    blackjackModel.scoreTied = false
                    blackjackModel.startNewGame()
                    blackjackModel.hide2ndCard = true
                    blackjackModel.isWinner = false}}
        }
        // If dealer wins or player bust
        else if blackjackModel.dealerWin || blackjackModel.dealerWinBust {
            HStack(alignment: .center){
                if blackjackModel.blackJack {Text("BLACKJACK, Dealer Wins!")
                        }
                else if blackjackModel.dealerWinBust {Text("\(blackjackModel.playerScore) Bust...\n Dealer wins!")
                        }
                else {Text("Dealer Wins \(blackjackModel.dealerScore)")
                        }
            }.onAppear{
                blackjackModel.hide2ndCard = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    blackjackModel.scoreTied = false
                    blackjackModel.hide2ndCard = true
                    blackjackModel.isWinner = false
                    blackjackModel.startNewGame()}}
        }
        // If player wins or dealer bust
        else if blackjackModel.playerWin || blackjackModel.playerWinBust{
        HStack{if blackjackModel.blackJack{
                    Text("BLACKJACK! \n YOU WIN: $\(Int(blackjackModel.previousBet*1.5))")
                        
                        .onAppear{blackjackModel.hide2ndCard = false
                            blackjackModel.isWinner = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                blackjackModel.scoreTied = false
                                blackjackModel.hide2ndCard = true
                                blackjackModel.isWinner = false
                                blackjackModel.startNewGame()}}
                } else if blackjackModel.playerWinBust {
                    Text("You win! $\(Int(blackjackModel.previousBet)) \n Score: \(blackjackModel.playerScore)\n Dealer Bust! \(blackjackModel.dealerScore)")
                        
                }else {Text("You Win! $\(Int(blackjackModel.previousBet))")
                        }
        }.onAppear {
                blackjackModel.hide2ndCard = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    blackjackModel.scoreTied = false
                    blackjackModel.startNewGame()
                    blackjackModel.hide2ndCard = true
                    blackjackModel.isWinner = false}}

        }
    }
}

struct CheckWinnerView_Previews: PreviewProvider {
    static var previews: some View {
        CheckWinnerView().environmentObject(BlackJackModel())
    }
}
