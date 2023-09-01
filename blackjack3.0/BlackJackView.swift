//
//  ContentView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/17/23.
//

import SwiftUI

struct BlackJackView: View {
    @StateObject private var blackjackModel = BlackJackModel()
    @State var hide2ndCard: Bool = true
    @State private var gameStart:Bool = false
    @State var isWinner:Bool = false
    
    var body: some View {
        ZStack {
            Background
            Spacer()
            VStack(){
                if gameStart {
                    DealerScore
                    
                    DealerHand
                    
                    PlayerHand
                    
                    PlayerScore
                } else {
                    HeadTitle
                }
                HStack{
                    HitButtonPressed
                    if gameStart {
                        HoldButton
                    }
                }
            }
            //Star count
            ZStack(alignment: .top){
                HStack() {
                    VStack(alignment:.leading){
                        ForEach(0..<blackjackModel.numPlayerWins, id: \.self) { index in
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        ForEach(0..<blackjackModel.numDealerWins, id: \.self) { index in
                            Image(systemName: "star.fill")
                                .foregroundColor(.red)}
                    }
                }
            }
            if blackjackModel.scoreTied && blackjackModel.holdPressed {
                ZStack{
                    Image(systemName: "flag.2.crossed.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(.yellow)
                        .opacity(1)
                    Text("PUSH!\n Both Score:\(blackjackModel.playerScore)")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .scaleEffect(1.2)
                }
                .onAppear {
                    hide2ndCard = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        blackjackModel.scoreTied = false
                        blackjackModel.startNewGame()
                        hide2ndCard = true
                        isWinner = false
                    }
                }
            } else if blackjackModel.dealerWin || blackjackModel.dealerWinBust {
                ZStack(alignment: .center){
                    Image(systemName: "hand.thumbsdown.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(.red)
                        .opacity(1)
                    if blackjackModel.blackJack {
                        Text("BLACKJACK, Dealer Wins!")
                            .foregroundColor(.orange)
                            .font(.largeTitle)
                            .scaleEffect(1.0)
                            .onAppear{hide2ndCard = false
                                isWinner = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    blackjackModel.scoreTied = false
                                    hide2ndCard = true
                                    isWinner = false
                                    blackjackModel.startNewGame()}
                            }
                    }else if blackjackModel.dealerWinBust {
                        Text("\(blackjackModel.playerScore) Bust...\n Dealer wins!")
                            .offset(y:-97)
                            .foregroundColor(.orange)
                            .font(.largeTitle)
                            .bold()
                            .scaleEffect(1.0)
                    } else {
                        Text("Dealer Wins \(blackjackModel.dealerScore)")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .scaleEffect(1.2)
                    }
                }.onAppear {
                    hide2ndCard = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        blackjackModel.scoreTied = false
                        hide2ndCard = true
                        isWinner = false
                        blackjackModel.startNewGame()
                    }
                }
            } else if blackjackModel.playerWin || blackjackModel.playerWinBust{
                ZStack{
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(.green)
                        .opacity(1)
                    if blackjackModel.blackJack {
                        Text("BLACKJACK! \n YOU WIN!")
                            .foregroundColor(.orange)
                            .bold()
                            .font(.largeTitle)
                            .scaleEffect(1.2)
                            .onAppear{hide2ndCard = false
                                isWinner = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    blackjackModel.scoreTied = false
                                    hide2ndCard = true
                                    isWinner = false
                                    blackjackModel.startNewGame()}
                            }
                    } else if blackjackModel.playerWinBust {
                        Text("You win! \(blackjackModel.playerScore)\n Dealer Bust! \(blackjackModel.dealerScore)")
                            .offset(y:-75)
                            .foregroundColor(.orange)
                            .font(.largeTitle)
                            .bold()
                            .scaleEffect(1.0)
                    }
                    else {
                        Text("You Win!")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                        .scaleEffect(2.0)}
                }.onAppear {
                    hide2ndCard = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        blackjackModel.scoreTied = false
                        blackjackModel.startNewGame()
                        hide2ndCard = true
                        isWinner = false
                        
                    }
                }
            }
        }
    }
    
    var DealerScore: some View {
        HStack() {
            Text("Dealer Hand:")
                .font(.title)
                .bold()
                .frame(width: 220)
            if hide2ndCard {
                if let cardValue = blackjackModel.cardValue[blackjackModel.dealerHand[0]], cardValue == 0 {
                    Text("11")
                        .font(.title)
                        .bold()
                        .frame(width: 50)
                } else if let cardValue = blackjackModel.cardValue[blackjackModel.dealerHand[0]] {
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
                .frame(width: 50)}
            
        }.padding(.top,20)
            .opacity(blackjackModel.isWinner ? 0:100)
    }
    
    var DealerHand: some View {
        HandView(hand: $blackjackModel.dealerHand, hide2ndCard:$hide2ndCard)
            .padding(.top,70)
            .padding(.bottom,340)
    }
    
    var PlayerHand: some View {
        HandView(hand: $blackjackModel.playerHand)
            .padding(.bottom,70)
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
            }.opacity(blackjackModel.isWinner ? 0:100)
        }
    }
    
    var HeadTitle: some View {
        Text("BlackJack!")
            .font(.largeTitle)
    }
    
    var HitButtonPressed: some View {
        HStack{
            // Hit button action
            Button{
                hitOrDeal()
                
            }label: {
                if gameStart {
                    
                    Text("Hit")
                } else {
                    Text("Deal")
                }
                
            }.frame(width: 100,height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.largeTitle)
                .padding()
                .opacity(isWinner ? 0:1)
        }
    }
    
    
    func hitOrDeal(){
        if gameStart {
            blackjackModel.drawCard()
            blackjackModel.hitCount += 1
            blackjackModel.playerScore = blackjackModel.calculateHandValue(hand: blackjackModel.playerHand)
            blackjackModel.checkWinner()
            if blackjackModel.isWinner {
                hide2ndCard = false
                blackjackModel.checkWinner()
                isWinner = true
            }
        }
        else {
            hide2ndCard = true
            blackjackModel.startNewGame()
            gameStart = true
            isWinner = false
        }
    }
    var HoldButton: some View{
        Button {
            hide2ndCard = false
            blackjackModel.holdPressed = true
            blackjackModel.dealerTurn()
            blackjackModel.checkWinner()
            isWinner = true
            
        } label: {
            if gameStart {
                Text("Hold")
            }
        }.frame(width: 100,height: 40)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .font(.largeTitle)
            .opacity(isWinner ? 0:1)
    }
    var Background: some View{
        Color("DarkGreen").ignoresSafeArea()
    }
}

struct BlackJackView_Previews: PreviewProvider {
    static var previews: some View {
        BlackJackView()
    }
}
