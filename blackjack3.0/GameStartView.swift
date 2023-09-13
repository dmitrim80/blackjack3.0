//
//  GameStart.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 9/5/23.
//

import SwiftUI

struct GameStartView: View {
    @State private var navigateToPlaceYourBetView: Bool = false
    var body: some View {
        NavigationStack {
            ZStack{
                background
                Text("BLACK JACK...")
                NavigationLink(
                    destination: PlaceYourBetView(),
                    isActive: $navigateToPlaceYourBetView,
                    label: {
                        Image(systemName: "dollarsign")
                            .resizable()
                            .foregroundColor(.orange)
                    }
                )
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    navigateToPlaceYourBetView = true

                }
            }
        }
    }
    var background: some View{
        Color("DarkGreen").ignoresSafeArea()
    }
}

struct GameStart_Previews: PreviewProvider {
    static var previews: some View {
        GameStartView()
    }
}
