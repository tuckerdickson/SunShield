//
//  ContentView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/1/23.
//

import SwiftUI
import WeatherKit

struct ContentView: View {
    @ObservedObject var weatherManager = WeatherManager()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        if locationManager.manager.authorizationStatus == .authorizedWhenInUse {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    // location currently selected and current uv index
                    HeaderView(city: locationManager.city,
                               municipality: locationManager.state,
                               uvIndex: weatherManager.uvIndex)
                    
                    // bar chart and hourly uv predictions
                    HourlyForecastView(hourWeatherList: weatherManager.hourWeather)
                    
                    // 10-day forecast list
                    ExtendedForecastView(dayWeatherList: weatherManager.dayWeather)
                }
            }
            .padding()
            .task {
                await weatherManager.requestWeather(for: locationManager.location)
            }
        } else {
            Text("error loading location")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
