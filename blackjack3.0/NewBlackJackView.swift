//
//  NewBlackJackView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 9/11/23.
//

import SwiftUI

struct NewBlackJackView: View {
    @EnvironmentObject var blackjackModel: BlackJackModel
    var body: some View {
    ZStack{
            background
            //Main Table, Score header section
        VStack{VStack{HStack(){ScoreView()}}
            //start of section 2, Dealer Hand Part
            VStack{
                HStack{if !blackjackModel.playerHand.isEmpty {DealerScore}}
                HStack(){if !blackjackModel.playerHand.isEmpty {DealerHand}}
                CheckWinnerView()
                VStack{VStack{
                    HStack{if !blackjackModel.playerHand.isEmpty {PlayerHand}}
                    HStack{if !blackjackModel.playerHand.isEmpty {PlayerScore}}
                    HStack{if blackjackModel.gameStart {
                        HitButton
                        StandButton}}}}}
            //Bottom section, place your bet
            VStack{
                HStack{PlaceYourBetView()
                }.frame(maxWidth: .infinity,maxHeight: 40).padding(.bottom,50)
                .padding(.bottom,1)
            }.frame(maxWidth:.infinity,maxHeight: .infinity,alignment:.bottom)
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
}}
    
    
    var DealerScore: some View {
        HStack() {
            Text("Dealer Hand:")
                .font(.title)
                .bold()
            if blackjackModel.hide2ndCard {
                if let cardValue = blackjackModel.cardValue[blackjackModel.dealerHand[0]], cardValue == 0 {
                    Text("11")
                        .font(.title)
                        .bold()
                } else if let cardValue = blackjackModel.cardValue[blackjackModel.dealerHand[0]]{
                    Text("\(cardValue)")
                        .font(.title)
                        .bold()
                }
            }
            else {
                Text("\(blackjackModel.dealerScore)")
                    .font(.title)
                    .bold()
                .frame(width: 50)
            }
        }.padding(.top,20)
           //.opacity(blackjackModel.isWinner ? 0:100)
    }
    
    var PlayerScore: some View {
        VStack(){
            HStack(){
                Text("Player Hand:")
                    .font(.title)
                    .bold()
                Text("\(blackjackModel.playerScore)")
                    .font(.title)
                    .bold()
                    .frame(width: 50)
            }//.opacity(blackjackModel.isWinner ? 0:100)
        }
    }
    
    var PlayerHand: some View {
        HandView(hand: $blackjackModel.playerHand)}
    
    var DealerHand: some View {
        HStack{HandView(hand: $blackjackModel.dealerHand,
                        hide2ndCard:$blackjackModel.hide2ndCard)}}
    
    var background: some View{
        Color("DarkGreen").ignoresSafeArea()}
    
    var HitButton: some View {
            Button{
                blackjackModel.hitOrDeal()
            }label: {
                if blackjackModel.gameStart {
                    Text("Hit")}
            }.frame(width: 100,height: 40)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                .font(.largeTitle)
                .padding()
                .opacity(blackjackModel.isWinner ? 0:100)}
    
    var StandButton: some View{
            Button {
                blackjackModel.hide2ndCard = false
                blackjackModel.holdPressed = true
                blackjackModel.dealerTurn()
                blackjackModel.checkWinner()
            } label: {
                if blackjackModel.gameStart {
                    Text("Stand")}
            }.frame(width: 100,height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.largeTitle)
                .opacity(blackjackModel.isWinner ? 0:100)}
    
}//end of struct

struct NewBlackJackView_Previews: PreviewProvider {
    static var previews: some View {
        NewBlackJackView()
            .environmentObject(BlackJackModel())
    }
}
