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
    
    var body: some View {
        VStack(alignment: .leading){
            Text("10-DAY FORECAST")
                .font(.caption)
                .opacity(0.5)
            
            List(dayWeatherList, id: \.date) { dayWeather in
                HStack {
                    Text(dayWeather.date.formatDayAbbreviated())
                    Image(systemName: "\(dayWeather.symbolName).fill")
                        .foregroundColor(.yellow)
                    Text(dayWeather.uvIndex.value.formatted())
                    Text(dayWeather.lowTemperature.formatted())
                    Text(dayWeather.highTemperature.formatted())
                }
                .listRowBackground(Color.blue)
            }
            .listStyle(.plain)
        }
        .background {
            Color.blue
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ExtendedForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedForecastView(dayWeatherList: [])
    }
}
