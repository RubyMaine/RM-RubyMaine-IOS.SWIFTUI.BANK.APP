//
//  TransactionsView.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import SwiftUI

struct TransactionsView: View {
    private struct AnimationState {
        var splashBackground = false
        var splashIcon = false

    }

    @State private var currentDate = Date()
    @State private var animatedStates = AnimationState()
    @Namespace private var animation

    // Sample users data
    private let users: [User] = [
        User(name: "Мурад Курбанов", image: "user1", type: "Отправиль", amount: "-120$", color: .red),
        User(name: "Даврон Умаров", image: "user3", type: "Получиль", amount: "+35$", color: .green),
        User(name: "Умар Якубов", image: "user2", type: "Отказано", amount: "-20$", color: Color(.label)),
        User(name: "Умар Якубов", image: "user2", type: "Отказано", amount: "-20$", color: Color(.label)),
        User(name: "Умар Якубов", image: "user2", type: "Отказано", amount: "-20$", color: Color(.label)),
        User(name: "Умар Якубов", image: "user2", type: "Отказано", amount: "-20$", color: Color(.label)),
        User(name: "Нурбек Нуралиев", image: "user4", type: "Получиль", amount: "+40$", color: .green)
    ]

    var body: some View {
        ZStack {
            if  !animatedStates.splashBackground {
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .fill(Color("Purple"))
                    .ignoresSafeArea()
                    .matchedGeometryEffect(id: "DATEVIEW", in: animation)

                // Splash Logo
                Image("debt icon")
                    .scaleEffect(0.7)
                    .matchedGeometryEffect(id: "SPLASHLOGO", in: animation)
            }

            if  animatedStates.splashBackground  {
                // MARK: Transactions View
                VStack(spacing: 0) {
                    // MARK: Fake Nav Bar
                    Button {

                    } label: {
                        Image(systemName: "rectangle.leadinghalf.inset.filled")
                            .font(.title3)
                    }
                    .foregroundColor(.init(.label))
                    .hTrailing()
                    .overlay {
                        Text("Все транзакцы")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom, 30)

                    CustomDatePicker(currentDate: $currentDate)
                        .background {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                        }
                        .overlay(alignment: .topLeading) {
                            Image("debt icon")
                                .scaleEffect(0.25)
                                .matchedGeometryEffect(id: "SPLASHLOGO", in: animation)
                                .offset(x: -10, y: -23)
                        }

                    // MARK: Users ScrollView
                    ScrollView(.vertical, showsIndicators: true) {

                        VStack(spacing: 20) {

                            ForEach(users.indices, id: \.self) { index in
                                // MARK: User Card View
                                UserTransactionView(user: users[index], index: index)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.vertical)
                    }
                }
                .vTop()
                .padding([.top, .horizontal])
            }
        }
        .onAppear {
            startAnimations()
            UITabBar.showTabBar()
        }
    }

    private func startAnimations() {
        // MARK: Displaying Splash Icon for Some Time

        // Removing View after the view is animated

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                animatedStates.splashBackground = true
            }

            withAnimation(.easeInOut(duration: 0.5)) {
                animatedStates.splashIcon = true
            }
        }
    }
}

struct DebtView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
