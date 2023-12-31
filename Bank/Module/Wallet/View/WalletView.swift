//
//  WalletView.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import SwiftUI

struct WalletView: View {
    
    // MARK: Animation Properties
    @State var expandCards: Bool = false
    
    // MARK: Detail View Properties
    @State var currentCard: Card?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    
    @State var goToAddCardView = false

    
    private let cards: [Card] = [
        Card(name: "TURON BANK", cardNumber: "4345 5687 7867 0978", cardImage: "Card1"),
        Card(name: "SQB BANK", cardNumber: "5687 4345 7867 5687", cardImage: "Card2"),
        Card(name: "DAVR BANK", cardNumber: "7867 4345 5687 7867", cardImage: "Card3")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text("Все мои карты")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: expandCards ? .leading : .center)
                .overlay(alignment: .trailing) {
                    
                    // MARK: Close Button
                    Button {
                        // Closing Cards
                        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                            expandCards = false
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue, in: Circle())

                    }
                    .rotationEffect(.init(degrees: expandCards ? 45 : .zero))
                    .offset(x: expandCards ? 10 : 15)
                    .opacity(expandCards ? 1 : 0)
                    .shouldHideTabBar(expandCards ? true : false, animated: true)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: .zero) {
                    // MARK: Cards
                    ForEach(cards.indices, id:\.self) { index in
                        let card = cards[index]

                        GeometryReader { geometry in
                            let rect = geometry.frame(in: .named("WalletView-ScrollView"))
                            // display some portion of each Card
                            let offset =  CGFloat(index) * (expandCards ? 10 : 70)
                            Group {
                                if currentCard?.id == card.id && showDetailCard {
                                    CardView(with: card)
                                        .opacity(0)
                                } else {
                                    CardView(with: card)
                                        .matchedGeometryEffect(id: card.id, in: animation)
                                }
                            }
                            .hCenter()
                            .frame(height: 200)
                            .offset(y: expandCards ? offset : -rect.minY + offset)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    currentCard = card
                                    showDetailCard = true
                                }
                            }
                        }
                        .frame(height: 200)
                    }
                }
                .padding(.top, expandCards ? 30 : 0)
                .overlay {
                    // To avoid scrolling
                    Rectangle()
                        // if the fill color is clear, tap gesture wont work -> Fixed by setting it to 0.001
                        .fill(.black.opacity(expandCards ? 0 : 0.001))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                expandCards = true
                            }
                        }
                }
            }
            .coordinateSpace(name: "WalletView-ScrollView")
            .offset(y: expandCards ? 0 : 30)
            
            // MARK: Add Button
            NavigationLink(destination: AddCardView(), isActive: $goToAddCardView) {
                Button {
                    UITabBar.hideTabBar()
                    goToAddCardView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(.blue, in: Circle())
                        .rotationEffect(.init(degrees: expandCards ? 180 : .zero))
                        .scaleEffect(expandCards ? 0.01 : 1) // 0.01 -> To Avoid Debug Warning Log
                        .opacity(expandCards ? 0 : 1)
                        .frame(height: expandCards ? 0 : nil)
                        .padding(.bottom, expandCards ? 0 : 30)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .background {
            Color.black.opacity(expandCards ? 0 : 0.01)
        }
        .padding([.horizontal, .top])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if let currentCard = currentCard, showDetailCard {
                CardDetailView(
                    currentCard: currentCard,
                    showDetailCard: $showDetailCard,
                    animation: animation
                )
                .ignoresSafeArea(.container, edges: .bottom)
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()

        WalletView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
