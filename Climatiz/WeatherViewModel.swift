//
//  WeatherViewModel.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var currentWeatherData: CurrentWeatherData?
    @Published var forecastData: [DailyForecast] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isNight = false
    
    private let weatherService = WeatherService()
    
    init() {
        checkTimeOfDay()
    }
    
    func fetchAllWeather(for city: String) async {
        isLoading = true
        errorMessage = nil
        currentWeatherData = nil
        forecastData = []
        
        do {
            async let current = weatherService.fetchCurrentWeather(for: city)
            async let forecast = weatherService.fetchForecast(for: city)
            
            self.currentWeatherData = try await current
            let rawForecast = try await forecast
            self.forecastData = processForecast(rawForecast)
        } catch {
            self.errorMessage = "Failed to fetch weather. Please try again."
            print("Error fetching weather: \(error)")
        }

        isLoading = false
    }
    
    func checkTimeOfDay() {
        let hour = Calendar.current.component(.hour, from: Date())
        isNight = hour < 6 || hour > 18
    }
    
    private func processForecast(_ forecast: ForecastData) -> [DailyForecast] {
        var dailyEntries: [String: ForecastData.ForecastItem] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for item in forecast.list {
            let date = Date(timeIntervalSince1970: item.dt)
            let dateString = dateFormatter.string(from: date)
            
            let hour = Calendar.current.component(.hour, from: date)
            if dailyEntries[dateString] == nil && hour >= 12 {
                dailyEntries[dateString] = item
            }
        }
        
        let todayString = dateFormatter.string(from: Date())
        dailyEntries.removeValue(forKey: todayString)
        
        let sortedDailyForecasts = dailyEntries.values
            .sorted { $0.dt < $1.dt }
            .prefix(5)
            .map { DailyForecast(from: $0) }
        
        return sortedDailyForecasts
    }
    
    var mainWeatherIcon: String {
        guard let weatherId = currentWeatherData?.weather.first else {
            return isNight ? "moon.stars.fill" : "sun.max.fill"
        }
        return getWeatherIcon(for: weatherId.id, isNight: isNight)
            
    }
}
