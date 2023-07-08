//
//  ExtendedForecastView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/2/23.
//

import SwiftUI
import WeatherKit

struct ExtendedForecastView: View {
    
    let dayWeatherList: [DayWeather]
    let colorBg = Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    let colorText = Color.white
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Daily Forecast")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorText)
            
            VStack() {
                ForEach(dayWeatherList, id: \.date) { dayWeather in
                    HStack {
                        // day abbreviation
                        Text(dayWeather.date.formatDayAbbreviated())
                            .foregroundColor(colorText)
                        Spacer()
                        
                        // uv information
                        Text("\(dayWeather.uvIndex.value) \(dayWeather.uvIndex.category.description)")
                            .foregroundColor(getColorUV(for: dayWeather))
                        
                    }
                }
            }
        }
        .padding()
        .background(colorBg)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func getColorUV(for weather: DayWeather) -> Color {
        let uv = weather.uvIndex.value

        if uv <= 2 { return Color.green }
        else if uv <= 5 { return Color.yellow }
        else if uv <= 7 { return Color.orange }
        else if uv <= 10 { return Color.red }
        else { return Color.purple }
    }
}

