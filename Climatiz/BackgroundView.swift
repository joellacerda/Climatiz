//
//  BackgroundView.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import SwiftUI

struct BackgroundView: View {
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(
            colors: [isNight ? Color.black : Color.blue,
                     isNight ? Color.gray : Color.lightBlue],
            startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}
