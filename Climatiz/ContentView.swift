//
//  ContentView.swift
//  Climatiz
//
//  Created by Joel Lacerda on 06/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .lightBlue],
                startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Text("Fortaleza, CE")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundStyle(.white)
                    .padding()
                
                VStack(spacing: 8) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                    
                    Text("27°")
                        .font(.system(size: 70, weight: .medium))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 40)
                
                HStack(spacing: 20) {
                    NextDay(dayOfWeek: "QUA", imageName: "cloud.sun.fill", temperature: 29)
                    NextDay(dayOfWeek: "QUI", imageName: "sun.max.fill", temperature: 30)
                    NextDay(dayOfWeek: "SEX", imageName: "wind", temperature: 28)
                    NextDay(dayOfWeek: "SAB", imageName: "cloud.fill", temperature: 29)
                    NextDay(dayOfWeek: "DOM", imageName: "cloud.sun.fill", temperature: 27)
                    
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
