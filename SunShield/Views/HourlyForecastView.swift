//
//  HourlyForecastView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/2/23.
//

import SwiftUI
import WeatherKit
import Charts

struct HourlyForecastView: View {
    
    let hourWeatherList: [HourWeather]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("HOURLY FORECAST")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourWeatherList, id: \.date) { hourWeather in
                        BarView(weather: hourWeather)
                    }
                }
            }
        }
        .padding()
//        .background {
//            Color.blue
//        }
//        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView(hourWeatherList: [])
    }
}
