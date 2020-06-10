//
//  File.swift
//  Memorize
//
//  Created by Dysson Vielmann on 6/7/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            // if else for cards face up or face down
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                // can nest if inside of another if
                // no "else" bc then when isMatched turns to true, the cards disappear
                RoundedRectangle(cornerRadius: cornerRadius).fill()
                
            }
        }
    }
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
