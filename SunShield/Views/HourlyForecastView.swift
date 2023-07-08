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
        VStack {
            Text("HOURLY FORECAST")
                .font(.caption)
                .opacity(0.5)
            ScrollView(.horizontal) {
                Chart {
                    ForEach(hourWeatherList, id: \.date) { hourWeather in
                        BarMark(
                            x: .value("Hour", hourWeather.date.formatTimeAbbreviated()),
                            y: .value("UV Index", hourWeather.uvIndex.value)
                        )
                        .annotation(position: .top) {
                            Text(hourWeather.uvIndex.value.formatted())
                                .foregroundColor(.white)
                        }
                        .foregroundStyle(
                            .linearGradient(
                                colors: [.green, .red],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .alignsMarkStylesWithPlotArea()
                    }
                }
                .chartXAxis {
                    AxisMarks { value in
                        AxisValueLabel()
                            .foregroundStyle(.white)
                    }
                }
                .chartYAxis {
                    AxisMarks { value in

                    }
                }
                .frame(width: CGFloat(hourWeatherList.count) * 45)
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
