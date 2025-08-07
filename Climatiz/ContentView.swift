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
            BackgroundView(topColor: .blue, bottomColor: .lightBlue)
            
            VStack {
                CityTextView(cityName: "Fortaleza, CE")
                
                MainWeatherView(imageName: "cloud.sun.fill", temperature: 27)
                
                HStack(spacing: 20) {
                    NextDay(dayOfWeek: "QUA", imageName: "cloud.sun.fill", temperature: 29)
                    NextDay(dayOfWeek: "QUI", imageName: "sun.max.fill", temperature: 30)
                    NextDay(dayOfWeek: "SEX", imageName: "wind", temperature: 28)
                    NextDay(dayOfWeek: "SAB", imageName: "cloud.fill", temperature: 29)
                    NextDay(dayOfWeek: "DOM", imageName: "cloud.sun.fill", temperature: 27)
                    
                }
                
                Spacer()
                
                Button {
                    print("tapped")
                } label: {
                    WeatherButton(title: "Mudar Cores", backgroundColor: .white, textColor: .blue)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    func cornerRadius(_ radius: Double) -> some View {
        clipShape(.rect(cornerRadius: radius))
    }
}

struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text("Fortaleza, CE")
            .font(.system(size: 32, weight: .medium))
            .foregroundStyle(.white)
            .padding()
    }
}

struct MainWeatherView: View {
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding(.bottom, 40)
    }
}


