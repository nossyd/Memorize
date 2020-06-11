//
//  File.swift
//  Memorize
//
//  Created by Dysson Vielmann on 6/7/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import SwiftUI

// AnimatableModifier rather than ViewModifier bc rotation3DEffect
struct Cardify: AnimatableModifier {
    
    var rotation : Double
    
    // sets isFaceUp
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // isFace up depends on degrees of angle rather than y/n Bool
    var isFaceUp: Bool {
        rotation < 90
    }
    
    // need animatableData var bc of AnimateableModifier ( rename rotation to aD here bc aD is name animation system will look for
    // get + set is way to get computed properties that are read-write
    var animatableData: Double {
        get{return rotation}
        set{rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
            // if else for cards face up or face down
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
                    .opacity(isFaceUp ? 1 : 0)
                // can nest if inside of another if
                // no "else" bc then when isMatched turns to true, the cards disappear
                RoundedRectangle(cornerRadius: cornerRadius).fill()
                    .opacity(isFaceUp ? 0 : 1)
        }
            // animation effect to flip card
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
