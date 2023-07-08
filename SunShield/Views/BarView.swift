//
//  BarView.swift
//  SunShield
//
//  Created by Tucker Dickson on 7/7/23.
//

import SwiftUI
import WeatherKit

struct BarView: View {
    let hourWeather: HourWeather

    var body: some View {
        
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width: 30, height: 200)
                    .foregroundColor(.orange)
                Capsule().frame(width: 30, height: 50)
                    .foregroundColor(.purple)
            }
        }
    }
}
