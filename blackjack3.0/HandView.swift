//
//  HandView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/20/23.
//

import SwiftUI

struct HandView: View {
    var hand:[String]
    var body: some View {
        HStack{
            ForEach(0..<hand.count, id: \.self) { index in
                CardView(card: hand[index])
                    .offset(x: CGFloat(index * 1), y: 0)
            }
        }
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
                    HandView(hand: ["🂡", "🂣", "🂥","🃁"])
                        .previewLayout(.sizeThatFits)
                        .previewDisplayName("Visible Hand")
            
        }
    }
}
