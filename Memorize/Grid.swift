//
//  Grid.swift
//  Memorize
//
//  Created by Dysson Vielmann on 6/1/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import SwiftUI


// able to use "where" + Identifiable/View bc vars are generics "contrains and gains"
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    // "don't care" vars
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    
    // use escaping bc func not used in init thus needs to "escape"
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    
    // uses space offered to us
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    
    //  code for body
    // gridlayout divides the space up that is available to us
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    
    // code for body
    // setting frame size + position of layout
    // offer the divided available space to our subviews here then position them in locations in gridlayout
    private func body(for item: Item, in layout: GridLayout) -> some View {
        
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
        }
    }


