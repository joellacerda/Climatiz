//
//  WeatherService.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import Foundation

class WeatherService {
    private let apiKey = "ebc6f3228d00aeea368a82452e338515"
    private let baseCurrentURL = "https://api.openweathermap.org/data/2.5/weather"
    private let baseForecastURL = "https://api.openweathermap.org/data/2.5/forecast"
    
    enum APIError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidResponse
        case decodingError(Error)
    }
    
    func fetchCurrentWeather(for city: String) async throws -> CurrentWeatherData {
        guard let url = URL(string: "\(baseCurrentURL)?q=\(city)&appid=\(apiKey)&units=metric") else {
            throw APIError.invalidURL
        }
        return try await performRequest(url: url)
    }
    
    func fetchForecast(for city: String) async throws -> ForecastData {
        guard let url = URL(string: "\(baseForecastURL)?q=\(city)&appid=\(apiKey)&units=metric") else {
            throw APIError.invalidURL
        }
        return try await performRequest(url: url)
    }
    
    private func performRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
