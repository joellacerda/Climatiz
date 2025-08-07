//
//  BackgroundView.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import SwiftUI

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(
            colors: [topColor, bottomColor],
            startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}
