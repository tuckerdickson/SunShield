//
//  HeaderView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/2/23.
//

import SwiftUI
import WeatherKit

struct HeaderView: View {
    let city: String
    let municipality: String
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
                
                Text(city)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(municipality)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            ZStack {
                
                Circle()
                    .stroke(colorUV, lineWidth: 5)
                    .foregroundColor(colorUV)
                    .frame(width: 80, height: 80)
                
                Text(String(weather.currentWeather.uvIndex.value))
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                    .foregroundColor(colorUV)
            }
        }
        .padding()
    }
}
