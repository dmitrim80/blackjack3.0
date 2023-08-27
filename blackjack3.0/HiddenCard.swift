//
//  HiddenCard.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/24/23.
//

import SwiftUI

struct HiddenCard: View {
    private var backViewCard: String = "🂠"
    
    var body: some View {
        ZStack{
            VStack{
                Text(backViewCard)
                    .background(Color.white)
                    .cornerRadius(5)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .scaleEffect(4.5)
                    .foregroundColor(.blue)
                    .shadow(color: .black, radius: 10, x: 10, y: 1)
            }
        }
    }
}

struct HiddenCard_Previews: PreviewProvider {
    static var previews: some View {
        HiddenCard()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Hidden Card")
        
    }
}
