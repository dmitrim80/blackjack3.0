//
//  StarView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 9/7/23.
//

import SwiftUI

struct StarView: View {
    @EnvironmentObject var blackjackModel: BlackJackModel
    var body: some View {
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
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView().environmentObject(BlackJackModel())
    }
}
