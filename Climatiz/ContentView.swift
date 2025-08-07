//
//  ContentView.swift
//  Climatiz
//
//  Created by Joel Lacerda on 06/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchCity: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(isNight: $viewModel.isNight)
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Fetching Weather...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        
                        Spacer()
                    } else if let weather = viewModel.currentWeatherData {
                        CityTextView(cityName: weather.name)
                        
                        MainWeatherView(imageName: viewModel.mainWeatherIcon, temperature: Int(weather.main.temp))
                        
                        HStack(spacing: 20) {
                            ForEach(viewModel.forecastData) { day in
                                NextDay(dayOfWeek: day.dayOfWeek,
                                        imageName: day.iconName,
                                        temperature: day.temperature)
                            }
                        }
                        
                        Spacer()
                        
                    } else if viewModel.locationManager.authorizationStatus == .denied {
                        Spacer()
                        
                        Text("Please enable location services in Settings to see the weather for your area.")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                    } else if let errorMessage = viewModel.errorMessage {
                        Spacer()
                        
                        Text(errorMessage)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                    } else {
                        Spacer()
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        
                        Spacer()
                    }
                }
                .navigationTitle("Climatiz 🌦️")
            }
            .searchable(text: $searchCity, prompt: "Search for a city")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.fetchAllWeather(for: searchCity)
                }
            }
            .task {
                await viewModel.fetchInitialWeather()
            }
            .onChange(of: viewModel.locationManager.authorizationStatus) {
                Task {
                    await viewModel.fetchInitialWeather()
                }
            }
        }
        .searchable(text: $searchCity, prompt: "Search for a city")
        .foregroundColor(.white)
        .tint(.white)
    }
}

#Preview {
    ContentView()
}


struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
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
        .padding(.vertical, 40)
    }
}

func getWeatherIcon(for conditionId: Int, isNight: Bool = false) -> String {
    switch conditionId {
    case 200...232:
        return "cloud.bolt.rain.fill"
    case 300...321:
        return "cloud.drizzle.fill"
    case 500...531:
        return "cloud.rain.fill"
    case 600...622:
        return "cloud.snow.fill"
    case 701...781:
        return "sun.haze.fill"
    case 800:
        return isNight ? "moon.stars.fill" : "sun.max.fill"
    case 801...804:
        return isNight ? "cloud.moon.fill" : "cloud.sun.fill"
    default:
        return "questionmark.diamond.fill"
    }
}

