//
//  HiddenCard.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/24/23.
//

import SwiftUI

struct HiddenCard: View {
    private var backViewCard: String = "🂠"
    let width:CGFloat = 100
    let height:CGFloat = 150
    var body: some View {
        Text("🂠")
            .font(.system(size: min(width+40,height)))
            .frame(width: width, height: height)
            .offset(y:-5)
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(15)
            .shadow(color: .black, radius: 5, x: 5, y: 1)
        
    }
}

struct HiddenCard_Previews: PreviewProvider {
    static var previews: some View {
        HiddenCard()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Hidden Card")
        
    }
}
