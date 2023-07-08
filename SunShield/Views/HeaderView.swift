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
    
    var colorUV: Color {
        let uv = weather.currentWeather.uvIndex.value

        if uv <= 2 { return Color.green }
        else if uv <= 5 { return Color.yellow }
        else if uv <= 7 { return Color.orange }
        else if uv <= 10 { return Color.red }
        else { return Color.purple }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text(locationManager.city ?? "City")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(locationManager.state ?? "State")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text(String(weather.currentWeather.uvIndex.value))
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(colorUV)
        }
        .padding()
    }
}
