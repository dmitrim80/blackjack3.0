//
//  ContentView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/17/23.
//

import SwiftUI

struct BlackJackView: View {
    @EnvironmentObject var blackjackModel: BlackJackModel
    
    var body: some View {
        ZStack {
            background
            Spacer()
            VStack{
                if !blackjackModel.playerHand.isEmpty {
                    
                    DealerScore
                    
                    DealerHand
                    
                    PlayerHand
                    
                    PlayerScore
                    
                }
                HStack{
                    if blackjackModel.gameStart {
                    HitButton
                    StandButton
                    }
                }
            }
            //Winning stars on the side of the screen
            StarView()
            //checking for winner at the start
            CheckWinnerView()
            //Score overlay & bets
            VStack{
                ScoreView()
                Spacer()
                HStack{
                PlaceYourBetView()
                }
            }.font(.caption)
        }
    }
    var DealerScore: some View {
        HStack() {
            Text("Dealer Hand:")
                .font(.title)
                .bold()
                .frame(width: 220)
            if blackjackModel.hide2ndCard {
                if let cardValue = blackjackModel.cardValue[blackjackModel.dealerHand[0]], cardValue == 0 {
                    Text("11")
                        .font(.title)
                        .bold()
                        .frame(width: 50)
                } else if let cardValue = blackjackModel.cardValue[blackjackModel.dealerHand[0]]{
                    Text("\(cardValue)")
                        .font(.title)
                        .bold()
                        .frame(width: 50)
                }
            }
            else {
                Text("\(blackjackModel.dealerScore)")
                    .font(.title)
                    .bold()
                .frame(width: 50)
            }
        }.padding(.top,20)
           // .opacity(blackjackModel.isWinner ? 0:100)
    }
    
    var DealerHand: some View {
        HStack{
            HandView(hand: $blackjackModel.dealerHand, hide2ndCard:$blackjackModel.hide2ndCard).padding(.bottom,220)
        }
    }
    
    var PlayerHand: some View {
        HandView(hand: $blackjackModel.playerHand)
    }
    
    var PlayerScore: some View {
        VStack(){
            HStack(){
                Text("Player Hand:")
                    .font(.title)
                    .bold()
                    .frame(width: 220)
                Text("\(blackjackModel.playerScore)")
                    .font(.title)
                    .bold()
                    .frame(width: 50)
            }//.opacity(blackjackModel.isWinner ? 0:100)
        }
    }
    
    
    var HitButton: some View {
            // Hit button action
            Button{
                blackjackModel.hitOrDeal()
                
            }label: {
                if blackjackModel.gameStart {
                    
                    Text("Hit")
                }
                
            }.frame(width: 100,height: 40)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                .font(.largeTitle)
                .padding()
                .opacity(blackjackModel.isWinner ? 0:100)
    }
    
    var StandButton: some View{
            Button {
                blackjackModel.hide2ndCard = false
                blackjackModel.holdPressed = true
                blackjackModel.dealerTurn()
                blackjackModel.checkWinner()
            } label: {
                if blackjackModel.gameStart {
                    Text("Stand")
                }
            }.frame(width: 100,height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.largeTitle)
                .opacity(blackjackModel.isWinner ? 0:100)
    }
    
    var background: some View{
        Color("DarkGreen").ignoresSafeArea()
    }
}

struct BlackJackView_Previews: PreviewProvider {
    static var previews: some View {
        BlackJackView()
            .environmentObject(BlackJackModel())
    }
}
