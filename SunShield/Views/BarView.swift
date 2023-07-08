//
//  BarView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/8/23.
//

import SwiftUI
import WeatherKit

struct BarView: View {
    let weather: HourWeather
    
    var uvColor: Color {
        let uv = weather.uvIndex.value

        if uv <= 2 { return Color.green }
        else if uv <= 5 { return Color.yellow }
        else if uv <= 7 { return Color.orange }
        else if uv <= 10 { return Color.red }
        else { return Color.purple }
    }
    
    var body: some View {
        VStack {
            // bar mark
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: 30, height: 240)
                    .foregroundColor(.gray)
                Capsule()
                    .frame(width: 30, height: CGFloat(weather.uvIndex.value)*20)
                    .foregroundColor(uvColor)
            }
            
            // uv reading above bar mark
            ZStack {
                Circle()
                    .stroke(uvColor, lineWidth: 3)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                Text(String(weather.uvIndex.value))
                    .foregroundColor(.black)
            }
            
            // time below bar mark
            Text(weather.date.formatTimeAbbreviated())
                .foregroundColor(.black)
            
        }
    }
}
