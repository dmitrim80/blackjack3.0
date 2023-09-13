//
//  ScoreView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 9/7/23.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var blackjackModel: BlackJackModel
    var body: some View {
        HStack{
            HStack(alignment: .top,spacing:15){
                Text("Score: $\(Int(blackjackModel.playerMoney))")
                    .foregroundColor(.black)
                    .frame(width: 100,height: 15,alignment: .leading)
                VStack{
                    HStack(spacing: 12){
                        Text("Bet:")
                        Text("Wins:").padding(.leading,10)
                        Text("Losses:")
                        Text("Tied Games:")
                    }.frame(width: 260,alignment: .leading)
                    HStack(spacing: 0){
                        Text("\(Int(blackjackModel.bet))").frame(width: 45,alignment: .leading)
                        Text("\(blackjackModel.numPlayerWins)")
                            .frame(width: 46)
                        Text("\(blackjackModel.numDealerWins)")
                            .frame(width: 55)
                        Text("\(blackjackModel.numTiedGames)")
                            .frame(width: 69)
                    }.frame(width: 260,alignment: .leading)
                }
            }.frame(maxWidth: .infinity,alignment: .leading)
            .background()
            .padding(1)
        }.font(.caption)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
            .environmentObject(BlackJackModel())
    }
}
