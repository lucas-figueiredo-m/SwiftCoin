//
//  LazyNavigationView.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 03/05/24.
//

import SwiftUI

struct LazyNavigationView<Content: View> : View {
    let build: () -> Content
    
    init (_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
