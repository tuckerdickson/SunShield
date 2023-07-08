//
//  HeaderView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/2/23.
//

import SwiftUI
import WeatherKit

struct HeaderView: View {
    let locationManager: LocationManager
    let weather: Weather
    
    var body: some View {
        VStack {
            Text(locationManager.city ?? "")
            Text("\(weather.currentWeather.uvIndex.value)")
        }
    }
}
