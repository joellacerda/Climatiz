//
//  WeatherData.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let description: String
    }
}
