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
    let colorBg = Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    let colorText = Color.white
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Hourly Forecast")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorText)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(hourWeatherList, id: \.date) { hourWeather in
                        HourlyBarView(weather: hourWeather)
                    }
                }
            }
        }
        .padding()
        .background(colorBg)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
