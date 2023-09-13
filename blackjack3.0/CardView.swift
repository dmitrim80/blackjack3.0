//
//  CardView.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/20/23.
//

import SwiftUI

struct CardView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let durationAndDelay: CGFloat = 0.3
    private var card: String
    init(card: String) {
        self.card = card
    }
    
    func flipCard() {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration:
                                    durationAndDelay)) {
                backDegree = 90
                
            }
            withAnimation(.linear(duration:
                                    durationAndDelay).delay(durationAndDelay)) {
               frontDegree = 0
            }}
            else{
                withAnimation(.linear(duration:
                                        durationAndDelay)) {
                    frontDegree  = -90
                }
                withAnimation(.linear(duration:
                                        durationAndDelay).delay(durationAndDelay)){
                    backDegree = 0
                }
            }
        }
    
    var body: some View {
        ZStack{
            CardBack(degree: $backDegree)
            CardFront(card: card, degree: $frontDegree)
        }
        .onAppear(){
        flipCard()
        }
    }
}
struct CardBack: View {
    let width:CGFloat = 70
    let height:CGFloat = 100
    @Binding var degree: Double
    var body: some View {
        Text("🂠")
            .font(.system(size: min(width+20,height)))
            .frame(width: width, height: height)
            .offset(y:-5)
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(15)
            .shadow(color: .black, radius: 5, x: 5, y: 1)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z:0))
    }
}

struct CardFront: View {
    let width:CGFloat = 70
    let height:CGFloat = 100
    @Binding var degree: Double
    
    private var card: String
    init(card: String, degree: Binding<Double>) {
        self.card = card
        self._degree = degree
    }
    
    var body: some View {
        Text("\(card)")
            .font(.system(size: min(width+20,height)))
            .frame(width: width,height: height)
            .offset(y:-5)
            .background(Color.white)
            .foregroundColor(
                card.contains("🂢") ||
                card.contains("🂢") ||
                card.contains("🂣") ||
                card.contains("🂤") ||
                card.contains("🂥") ||
                card.contains("🂦") ||
                card.contains("🂧") ||
                card.contains("🂨") ||
                card.contains("🂩") ||
                card.contains("🂪") ||
                card.contains("🂫") ||
                card.contains("🂭") ||
                card.contains("🂮") ||
                card.contains("🃑") ||
                card.contains("🃒") ||
                card.contains("🃓") ||
                card.contains("🃔") ||
                card.contains("🃕") ||
                card.contains("🃖") ||
                card.contains("🃗") ||
                card.contains("🃘") ||
                card.contains("🃙") ||
                card.contains("🃚") ||
                card.contains("🃛") ||
                card.contains("🃝") ||
                card.contains("🃞") ?
                    .black : .red)
            .cornerRadius(15)
            .shadow(color: .black, radius: 5, x: 5, y: 1)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z:0))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
                    CardView(card: "🂡")
                        .previewLayout(.sizeThatFits)
                        .previewDisplayName("Visible Card")
    }
}

