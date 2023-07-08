//
//  ContentView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/1/23.
//

import SwiftUI
import WeatherKit

struct ContentView: View {

    @StateObject var locationManager = LocationManager()
    @State private var weather: Weather?

    let weatherService = WeatherService.shared

    var hourlyWeatherData: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter {hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
        } else {
            return []
        }
    }

    var body: some View {
        VStack {
            if let weather {
                ScrollView(.vertical, showsIndicators: false) {
                    // header
                    HeaderView(locationManager: locationManager, weather: weather)
                    
                    // hourly forecast
                    HourlyForecastView(hourWeatherList: hourlyWeatherData)
                    
                    // extended (10-day) forecast
                    ExtendedForecastView(dayWeatherList: weather.dailyForecast.forecast)
                }
            }
        }
        .padding(10)
        .task(id:locationManager.currentLocation) {
            do {
                if let location = locationManager.currentLocation {
                    self.weather = try await weatherService.weather(for: location)
                }
            } catch {
                print(error)
            }
        }
        
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
