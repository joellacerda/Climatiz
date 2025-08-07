//
//  DailyForecast.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import Foundation

struct DailyForecast: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let iconName: String
    let temperature: Int
    
    init(from item: ForecastData.ForecastItem) {
        let date = Date(timeIntervalSince1970: item.dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        self.dayOfWeek = dateFormatter.string(from: date).uppercased()
        
        self.iconName = getWeatherIcon(for: item.weather.first?.id ?? 800)
        self.temperature = Int(item.main.temp)
    }
}
