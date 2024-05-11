//
//  CustomLoadingView.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 03/05/24.
//

import SwiftUI

struct CustomLoadingIndicator: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
            .scaleEffect(x: 1.5, y: 1.5, anchor: .center)
            .frame(width: 80, height: 80)
            .background(Color(.systemGray4))
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
    }
}

#Preview("CustomLoadingIndicator", traits: .sizeThatFitsLayout) {
    CustomLoadingIndicator()
        .padding()
}
