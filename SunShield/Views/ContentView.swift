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
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                if let weather {
                    // header
                    VStack {
                        Text(locationManager.city ?? "")
                        Text("\(weather.currentWeather.uvIndex.value)")
                    }
                    
                    // hourly forecast
                    HourlyForecastView(hourWeatherList: weather.hourlyForecast.forecast)

                }
            }
            .padding(30)
            .foregroundColor(.white)
            .task(id:locationManager.currentLocation) {
                do {
                    if let location = locationManager.currentLocation {
                        self.weather = try await weatherService.weather(for: location)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
