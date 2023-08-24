//
//  CardView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/20/23.
//

import SwiftUI

struct CardView: View {
    @State private var hiddenCard = false
    private var backViewCard: String = "🂠"
    private var card: String
    
    init(card: String) {
            self.card = card
        }
    
    var body: some View {
        ZStack{
            if hiddenCard {
                VStack{
                    Text(backViewCard)
                        .background(.white)
                        .cornerRadius(5)
                        .font(.largeTitle)
                        .scaleEffect(4.7)
                        .foregroundColor(Color.blue)
                        .shadow(radius: 0.3)
                }}
            else {
                VStack{
                    Text("\(card)")
                        .background(Color.white)
                        .cornerRadius(5)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .scaleEffect(4.5)
                        .shadow(color: .black, radius: 10, x: 10, y: 1)
                    
                }}
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
                    CardView(card: "🂡")
                        .previewLayout(.sizeThatFits)
                        .previewDisplayName("Visible Card")
                    
                    CardView(card: "🂠")
                        .previewLayout(.sizeThatFits)
                        .previewDisplayName("Hidden Card")
                        .foregroundColor(Color.blue)
                }
    }
}

