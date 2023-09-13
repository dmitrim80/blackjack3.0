//
//  PlaceYourBetView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 9/4/23.
//

import SwiftUI

struct PlaceYourBetView: View {
    @EnvironmentObject var blackjackModel: BlackJackModel
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    if blackjackModel.bet > 0 {
                        blackjackModel.hide2ndCard = true
                        blackjackModel.isWinner = false
                        blackjackModel.startNewGame()
                        blackjackModel.gameStart = true
                        
                    }
                } label: {
                    Text("Place your bet!")
                        .frame(width: 300,height: 50)
                        .background(.blue)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
            VStack(spacing: 0){
                HStack{
                    Button {
                        if (blackjackModel.playerMoney - 5) >= 0 {
                            blackjackModel.bet += 5
                            blackjackModel.previousBet = blackjackModel.bet
                            print(blackjackModel.bet)
                        }else {
                            blackjackModel.betMessage = "Not enough money..."
                        }
                        
                    } label: {
                        Image(systemName: "dollarsign.circle.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 60,height: 60)
                    }
                    Button {
                        if (blackjackModel.playerMoney - 10) >= 0 {
                            blackjackModel.bet += 10
                            blackjackModel.previousBet = blackjackModel.bet
                            print(blackjackModel.bet)
                        } else {
                            blackjackModel.betMessage = "Not enough money..."
                        }
                        
                    } label: {
                        Image(systemName: "dollarsign.circle.fill")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: 60,height: 60)
                    }
                    Button {
                        if (blackjackModel.playerMoney - 25) >= 0 {
                            blackjackModel.bet += 25
                            blackjackModel.previousBet = blackjackModel.bet
                            print(blackjackModel.bet)
                        }else {
                            blackjackModel.betMessage = "Not enough money..."
                        }
                    } label: {
                        Image(systemName: "dollarsign.circle.fill")
                            .resizable()
                            .foregroundColor(.orange)
                            .frame(width: 60,height: 60)
                    }
                    Button {
                        if (blackjackModel.playerMoney - 50) >= 0 {
                            blackjackModel.bet += 50
                            blackjackModel.previousBet = blackjackModel.bet
                            print(blackjackModel.bet)
                        }else {
                            blackjackModel.betMessage = "Not enough money..."
                        }
                    } label: {
                        Image(systemName: "dollarsign.circle.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 60,height: 60)
                    }
                    Button {
                        if (blackjackModel.playerMoney - 100) >= 0 {
                            blackjackModel.bet += 100
                            blackjackModel.previousBet = blackjackModel.bet
                            print(blackjackModel.bet)
                            print(blackjackModel.previousBet)
                        } else {
                            blackjackModel.betMessage = "Not enough money..."
                        }
                    } label: {
                        Image(systemName: "dollarsign.circle.fill")
                            .resizable()
                            .foregroundColor(.purple)
                            .frame(width: 60,height: 60)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.black)
                
                HStack(alignment: .top,spacing: 20){
                    Text("$5")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("$10")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("$25")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("$50")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("$100")
                        .font(.title)
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity)
                    .background(.black)
                HStack{
                    Button {
                        blackjackModel.bet = 0
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 25,height: 25)
                            .foregroundColor(.teal)
                        Text("CLEAR")
                            .font(.title3)
                            .foregroundColor(.teal)
                            .frame(width: 100,alignment: .leading)
                    }
                    Text("BET: $\(Int(blackjackModel.bet))")
                        .font(.title3)
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity).background(.black)
            }
        }.opacity(blackjackModel.gameStart ? 0:100)
    }
}

struct PlaceYourBetView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceYourBetView()
            .environmentObject(BlackJackModel())
    }
}
