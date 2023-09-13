//
//  blackjack3_0App.swift
//  blackjack3.0
//
//  Created by Dmitri Morozov on 8/17/23.
//

import SwiftUI

@main
struct blackjack3_0App: App {
    @StateObject private var blackjackModel = BlackJackModel()
    var body: some Scene {
        WindowGroup {
            BlackJackView()
                .environmentObject(blackjackModel)
        }
    }
}
