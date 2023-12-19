//
//  SwiftUIView.swift
//  
//
//  Created by Lorenzo Ferrante on 13/12/23.
//

import SwiftUI

@available(iOS 17.0, *)
public struct RangedControlSlider: View {
       
    @Binding var progress: Int
    @State var maxHeight: Int = 400
    @State var maxWidth: CGFloat = 150
    @State var sliderNumbers: Int = 14
    @State var tint: Color = Color.blue
    @State var padding: CGFloat = 0.5
    
    var height: CGFloat {
        return CGFloat(maxHeight / sliderNumbers)
    }
    
    @State var isOnArray: Array<Bool>
    
    init(
        maxHeight: Int = 400,
        maxWidth: CGFloat = 150,
        sliderNumbers: Int = 15,
        padding: CGFloat = 0.5,
        tint: Color = .blue,
        progress: Binding<Int>
    ) {
        self.maxHeight = maxHeight
        self.tint = tint
        self.padding = padding
        self.isOnArray = Array(repeating: true, count: sliderNumbers)
        self._progress = progress
    }
    
    public var body: some View {
        
        GeometryReader { geometry in
            
            ForEach(0...sliderNumbers-1, id: \.self) { sliderNum in
                let minusPadding = CGFloat(Double(maxHeight / sliderNumbers) / 2)
                let minusPadding2 = CGFloat(CGFloat((sliderNum+1)) * padding)
                
                Rectangle()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: padding, trailing: 0))
                    .frame(width: maxWidth, height: height)
                    .position(x: maxWidth / 2, y: height * CGFloat(sliderNum+1) - minusPadding + minusPadding2)
                    .foregroundColor(isOnArray[sliderNum] ? tint : Color.gray.opacity(0.2))
                    .animation(.linear(duration: 0), value: isOnArray)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.getSliderValue(value.location)
                    }
            )
            .gesture(
                SpatialTapGesture()
                    .onEnded { value in
                        let newValue = CGPoint(x: value.location.x, y: value.location.y - height)
                        self.getSliderValue(newValue)
                    }
            )
            .onAppear {
                self.getSliderValue(convertValueToPoint(progress))
            }
            .onChange(of: self.progress) { oldValue, newValue in
                self.getSliderValue(convertValueToPoint(newValue))
            }
        }
        .frame(width: maxWidth, height: CGFloat(maxHeight))
    }
    
    func calculateX(x: CGFloat, screenWidth: CGFloat) -> CGFloat {
        return (x + screenWidth) / 2
    }
    
    func calculateY(
        topPadding: Int,
        height: CGFloat,
        sliderNum: Int) -> CGFloat{
            return (CGFloat(sliderNum) * height) + CGFloat(topPadding) + height
        }
    
    func getSliderValue(_ location: CGPoint) {
        var sliderValue = Int((CGFloat(maxHeight) - location.y) / height)
        sliderValue = sliderValue < 0 ? 0 : sliderValue
        sliderValue = sliderValue > sliderNumbers ? sliderNumbers-1 : sliderValue
        
        self.isOnArray = Array(repeating: false, count: sliderNumbers)
    
        for index in ((sliderNumbers-sliderValue)...sliderNumbers) {
            if index == sliderNumbers {
                self.isOnArray[index-1] = true
            } else {
                self.isOnArray[index] = true
            }
        }
        self.progress = sliderValue
        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.6)
    }
    
    func convertValueToPoint(_ sliderValue: Int) -> CGPoint {
        print("\(CGFloat(maxHeight) - (CGFloat(sliderValue) * height))")
        return CGPoint(x: 0, y: CGFloat(maxHeight) - (CGFloat(sliderValue) * height))
    }
}

@available(iOS 17.0, *)
#Preview {
    RangedControlSlider(maxHeight: 400, maxWidth: 150, progress: .constant(5))
}

