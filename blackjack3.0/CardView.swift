//
//  CardView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/20/23.
//

import SwiftUI

struct CardView: View {
    private var card: String
    
    init(card: String) {
            self.card = card
        }
    
    var body: some View {
        ZStack{
                VStack{
                    Text("\(card)")
                        .background(Color.white)
                        .cornerRadius(5)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .scaleEffect(4.5)
                        .shadow(color: .black, radius: 10, x: 10, y: 1)
                    
                }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
                    CardView(card: "🂡")
                        .previewLayout(.sizeThatFits)
                        .previewDisplayName("Visible Card")
                    

    }
}

