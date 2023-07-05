//
//  HourlyForecastView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/2/23.
//

import SwiftUI
import WeatherKit

struct HourlyForecastView: View {
    
    let hourWeatherList: [HourWeather]
    
    var body: some View {
        VStack {
            Text("HOURLY FORECAST")
                .font(.caption)
                .opacity(0.5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(hourWeatherList, id: \.date) { hourWeather in
                        VStack(spacing: 20) {
                            Text(hourWeather.date.formatted(date: .omitted, time: .shortened))
                            Text("\(hourWeather.uvIndex.value)")
                            Text(hourWeather.uvIndex.category.rawValue)
                            
                            Image(systemName: "\(hourWeather.symbolName).fill")
                        }
                        .padding()
                    }
                }
            }
        }
        .padding()
        .background {
            Color.blue
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundColor(.white)
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView(hourWeatherList: [])
    }
}
