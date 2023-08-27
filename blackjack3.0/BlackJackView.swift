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
    @State private var isShowingContent:Bool = true
    @State var isWinner:Bool = false
    
    
    var body: some View {
        ZStack {
            Background
            Spacer()
            VStack(){
                if gameStart {
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
                    
                    HandView(hand: $blackjackModel.dealerHand, hide2ndCard:$hide2ndCard)
                        .padding(.top,70)
                        .padding(.bottom,340)
                    HandView(hand: $blackjackModel.playerHand)
                        .padding(.bottom,70)
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
                    
                } else {
                    Text("BlackJack!")
                        .font(.largeTitle)
                    
                }
                HStack{
                    // Hit button action
                    Button{
                        if gameStart {
                            blackjackModel.drawCard()
                            blackjackModel.hitCount += 1
                            blackjackModel.playerScore = blackjackModel.calculateHandValue(hand: blackjackModel.playerHand)
                            blackjackModel.checkWinner()
                            if blackjackModel.isWinner {
                                hide2ndCard = false
                                blackjackModel.getResult()
                                isWinner = true
                            }
                        }
                        else {
                            hide2ndCard = true
                            blackjackModel.startNewGame()
                            gameStart = true
                            isWinner = false
                        }
                        
                        
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
                    
                    if gameStart {
                        // Hold button action
                        Button {
                            hide2ndCard = false
                            blackjackModel.dealerTurn()
                            blackjackModel.getResult()
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
                }
            }
            
            if blackjackModel.scoreTied {
                ZStack{
                    Image(systemName: "flag.2.crossed.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(.yellow)
                        .opacity(1)
                    Text("PUSH!")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .scaleEffect(2.0)
                }
                .onAppear {
                   
                        hide2ndCard = false
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        blackjackModel.scoreTied = false
                        blackjackModel.startNewGame()
                        hide2ndCard = true
                        isWinner = false
                        
                    }
                }
            }
            
            if blackjackModel.dealerWin || blackjackModel.dealerWinBust {
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        blackjackModel.scoreTied = false
                        hide2ndCard = true
                        isWinner = false
                        blackjackModel.startNewGame()
                        
                        
                    }
                }
            }
            if blackjackModel.playerWin || blackjackModel.playerWinBust{
                ZStack{
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(.green)
                        .opacity(1)
                    if blackjackModel.blackJack {
                        Text("BLACKJACK!")
                            .foregroundColor(.orange)
                            .bold()
                            .font(.largeTitle)
                            .scaleEffect(1.2)
                        
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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        blackjackModel.scoreTied = false
                        blackjackModel.startNewGame()
                        hide2ndCard = true
                        isWinner = false
                        
                    }
            }
            }
        }
    }
}

var Background: some View{
    Color("DarkGreen").ignoresSafeArea()
}


struct BlackJackView_Previews: PreviewProvider {
    static var previews: some View {
        BlackJackView()
    }
}
