//
//  WeatherManager.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/8/23.
//

import Foundation
import CoreLocation
import WeatherKit

@MainActor
class WeatherManager: ObservableObject {
    @Published var weather: Weather?
        
    var uvIndex: String {
        let uv = weather?.currentWeather.uvIndex.value.formatted()
        return uv ?? ""
    }
    
    var uvCategory: String {
        let uvc = weather?.currentWeather.uvIndex.category.description
        return uvc ?? ""
    }
    
    var hourWeather: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
        } else {
            return []
        }
    }
    
    var dayWeather: [DayWeather] {
        return weather?.dailyForecast.forecast ?? []
    }
    
    func requestWeather(for location: CLLocation) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: location)
            }.value
        } catch {
            fatalError("\(error)")
        }
    }
}
