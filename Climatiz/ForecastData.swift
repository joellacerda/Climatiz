//
//  ForecastData.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import Foundation

struct ForecastData: Codable {
    let list: [ForecastItem]
    
    struct ForecastItem: Codable {
        let dt: TimeInterval
        let main: MainClass
        let weather: [Weather]
        
        struct MainClass: Codable {
            let temp: Double
        }
        
        struct Weather: Codable {
            let id: Int
            let description: String
        }
    }
}
