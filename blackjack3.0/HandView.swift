//
//  HandView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/20/23.
//

import SwiftUI

struct HandView: View {
    @Binding var hand:[String]
    @Binding var hide2ndCard: Bool
    init(hand: Binding<[String]>, hide2ndCard: Binding<Bool>? = nil) {
            _hand = hand
            _hide2ndCard = hide2ndCard ?? Binding.constant(false)
        }
var body: some View {
    HStack{
        ForEach(0..<hand.count, id: \.self) { index in
            if hide2ndCard && index == 1 {
                    HiddenCard()
                        .offset(x: CGFloat(index) * -60, y: 0)
                } else {
                CardView(card: hand[index])
                    .offset(x: CGFloat(index) * -60, y: 0)
                }
            }
        }
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let cards: Binding<[String]> = .constant(["🂡", "🂣", "🂥", "🃁"])
            HandView(hand: cards, hide2ndCard: .constant(false))
                        .previewLayout(.sizeThatFits)
                        .previewDisplayName("Visible Hand")
        }
    }
}
