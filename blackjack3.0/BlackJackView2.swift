//
//  BlackJackView2.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 9/10/23.
//

import SwiftUI

struct BlackJackView2: View {
    var body: some View {
        ZStack{
            //Main Table, Main Section
            VStack(spacing:20){
                
                VStack{
                    //Score here, Section 1, Header
                    HStack{
                        VStack{
                            Text("Deck Image")
                        }.frame(width: 100,height: 39)
                            .background(.gray)
                        Spacer()
                        VStack{
                            Text("Deck Image")
                        }.frame(width: 100,height: 39)
                            .background(.gray)
                    }.frame(width: 350,height: 40)
                        .background()
                    HStack(spacing: 50){
                        Text("1")
                        Text("2")
                        Text("3")
                        Text("4")
                        Text("5")
                        
                    }.frame(maxWidth: 350,maxHeight: 40,alignment:.bottom)
                        .background(Color.purple) // end of top frame
                   
                    //start of section 2, Dealer Hand Part
                    VStack(spacing: 0){
                        HStack{
                            Text("Hand Value Here")
                        }.frame(maxWidth: 300, maxHeight:50)
                            .background(.white)
                        HStack{
                            Text("Dealer Hand Here")
                        }.frame(maxWidth: 300, maxHeight:150)
                            .background(.gray)
                    }.frame(maxWidth: 350,maxHeight: 200,alignment:.top)
                        .background(Color.orange) // end of section 2
                    //Middle Section
                    VStack{
                        Text("Tabel Message Image here")
                    }.frame(maxWidth: 350,maxHeight:75)
                        .background()
                        // end of mid section
                }.frame(
                    maxWidth: 375,
                    maxHeight:.infinity,
                    alignment:.top)
                    .background(.teal)
                    
               
                //Player Hand Section
                
                VStack{
                    VStack(spacing: 0){
                        HStack{
                            Text("Player Hand Here")
                        }.frame(maxWidth: 300, maxHeight:200)
                            .background(.yellow)
                        HStack{
                            Text("Hand Value Here")
                        }.frame(maxWidth: 300, maxHeight:50)
                            .background()
                        HStack{
                            Text("Bet Chips View Here")
                        }.padding(.top,20)
                    }.frame(maxWidth:350,maxHeight: .infinity,alignment:.top)
                        .background(Color.cyan)
                    
                    
                    //Bottom section, place your bet
                    
                    HStack(spacing: 50){
                        Text("1")
                        Text("2")
                        Text("3")
                        Text("4")
                        Text("5")
                    }.frame(maxWidth: 350,maxHeight: 40)
                        .background(Color.brown)
                        .padding(.bottom,1)
                }.frame(maxWidth: 375,maxHeight: .infinity,alignment:.bottom)
                    .background(.red)
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity).background(.green)
        }
    }
}

struct BlackJackView2_Previews: PreviewProvider {
    static var previews: some View {
        BlackJackView2()
    }
}
