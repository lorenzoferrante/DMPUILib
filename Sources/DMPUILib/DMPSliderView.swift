//
//  SwiftUIView.swift
//  
//
//  Created by Lorenzo Ferrante on 13/12/23.
//

import SwiftUI

@available(iOS 17.0, *)
public struct DMPSliderView: View {
    
    @Binding var value: Int
    
    @State var maxHeight: Int = 400
    @State var maxWidth: CGFloat = 150
    @State var sliderNumbers: Int = 15
    @State var tint: Color = Color.blue
    @State var cornerRadius: CGFloat = 30.0
    @State var padding: CGFloat = 0.5
    @State var clipped: Bool = false
    
    public init(
        value: Binding<Int>,
        maxHeight: Int = 400,
        maxWidth: CGFloat = 150,
        sliderNumbers: Int = 15,
        tint: Color = .blue,
        cornerRadius: CGFloat = 30.0,
        padding: CGFloat = 0.5,
        clipped: Bool = true
    ) {
        self._value = value
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.sliderNumbers = sliderNumbers
        self.tint = tint
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.clipped = clipped
    }
    
    public var body: some View {
        if (clipped) {
            RangedControlSlider(
                maxHeight: maxHeight,
                maxWidth: maxWidth,
                sliderNumbers: sliderNumbers,
                padding: padding,
                tint: tint,
                progress: $value)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        } else {
            RangedControlSlider(
                maxHeight: maxHeight,
                maxWidth: maxWidth,
                sliderNumbers: sliderNumbers,
                padding: padding,
                tint: tint,
                progress: $value)
        }
    }
    
}
