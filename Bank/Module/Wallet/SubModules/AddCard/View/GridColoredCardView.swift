//
//  GridColoredCardView.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import SwiftUI

struct GridColoredCardView: View {

    private let colorGrid: ColorGrid
    @Binding var selectedColor: Color
    @Binding var colors: [ColorGrid]
    private let animation: Namespace.ID

    init(
        colorGrid: ColorGrid,
        selectedColor: Binding<Color>,
        colors: Binding<[ColorGrid]>,
        animation: Namespace.ID
    ) {
        self.colorGrid = colorGrid
        self._selectedColor = selectedColor
        self._colors = colors
        self.animation = animation
    }

    var body: some View {
        VStack {

            if colorGrid.addToGrid {

                // Displaying With Matched Geometry Effect
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorGrid.color)
                    .frame(width: ColorGrid.width, height: ColorGrid.height)
                    .matchedGeometryEffect(id: colorGrid.id, in: animation)
                    // When Animated Grid Card is Displayed Displaying the Color Text
                    .onAppear {
                        guard let index = colors.firstIndex(where: { $0.id == colorGrid.id }) else {
                            return
                        }

                        withAnimation(.default.delay(0.3)) {
                            colors[index].showText = true

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                colors[index].removeFromView = true
                            }
                        }
                    }
                    .onTapGesture {
                        selectedColor = colorGrid.color
                    }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .frame(width: ColorGrid.width, height: ColorGrid.height)
            }

            Text(colorGrid.hexValue)
                .font(.caption)
                .fontWeight(.light)
                .hCenter()
                .padding([.horizontal, .bottom])
                .padding(.top, 5)
                .opacity(colorGrid.showText ? 1 : 0)
        }
    }
}

struct GridColoredCardView_Previews: PreviewProvider {
    @Namespace private static var animation: Namespace.ID
    static private let colorGrid: ColorGrid = ColorGrid(
        hexValue: "#FB3272",
        color: Color("Orange"),
        rotateCards: true,
        addToGrid: true,
        showText: true,
        removeFromView: true
    )
    static private let colors: [ColorGrid] = [
        colorGrid
    ]

    static var previews: some View {
        GridColoredCardView(
            colorGrid: colorGrid,
            selectedColor: .constant(colors[0].color),
            colors: .constant(colors),
            animation: animation
        )
            .preferredColorScheme(.dark)
    }
}
