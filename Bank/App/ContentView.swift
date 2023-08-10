//
//  ContentView.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import SwiftUI
import HidableTabView

struct ContentView: View {
    init() {
        // Fixes a 'SwiftUI 3.0' bug that makes the divider between the tab Bar and the View invisible
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
    }
    
    var body: some View {
        
        TabView {
            // MARK: Tab 1 - Transactions
            TransactionsView()
                .tabItem {
                    Label {
                        Text("Транзакцы")
                    } icon: {
                        Image("debt tab item")
                            .renderingMode(.template)
                    }
                }

            // MARK: Tab 2 - Wallet
            NavigationView {
                WalletView()
                    .onAppear {
                        UITabBar.showTabBar()
                    }
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(.stack)
            .accentColor(Color(UIColor.label))
            .tabItem {
                Label("Все карты", systemImage: "creditcard")
            }
        }
        .hideTabBar(animated: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
