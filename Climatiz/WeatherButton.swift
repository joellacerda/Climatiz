//
//  WeatherButton.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import SwiftUI

struct WeatherButton: View {
    var title: String
    var backgroundColor: Color
    var textColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundStyle(textColor)
            .font(.system(size: 20, weight: .bold))
            .cornerRadius(10)
    }
}
