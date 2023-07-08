import SwiftUI

struct HourlyForecastView2: View {
    var hourlyUVIndices: [Int]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hourly UV Index Forecast")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(hourlyUVIndices, id: \.self) { uvIndex in
                        VStack(spacing: 10) {
                            Text("\(uvIndex)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(getUVIndexColor(uvIndex))
                            
                            Text(getUVIndexDescription(uvIndex))
                                .font(.caption)
                                .foregroundColor(.black)
                                .lineLimit(1) // Limit the description to a single line
                            
                            UVIndexBar(uvIndex: uvIndex)
                                .frame(height: calculateBarHeight(uvIndex))
                                .foregroundColor(getUVIndexColor(uvIndex))
                                .cornerRadius(5) // Rounded corners for the bar
                        }
                        .padding(12) // Increased padding around each hourly view
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Shadow effect
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding()
    }
    
    private func calculateBarHeight(_ uvIndex: Int) -> CGFloat {
        let maxHeight: CGFloat = 120
        let percentage = CGFloat(uvIndex) / 15.0 // Assuming maximum UV index value of 15
        return maxHeight * percentage
    }
    
    private func getUVIndexColor(_ uvIndex: Int) -> Color {
        // Same color logic as in the WeatherView
        if uvIndex <= 2 {
            return Color.green
        } else if uvIndex <= 5 {
            return Color.yellow
        } else if uvIndex <= 7 {
            return Color.orange
        } else if uvIndex <= 10 {
            return Color.red
        } else {
            return Color.purple
        }
    }
    
    private func getUVIndexDescription(_ uvIndex: Int) -> String {
        // Same description logic as in the WeatherView
        if uvIndex <= 2 {
            return "Low"
        } else if uvIndex <= 5 {
            return "Moderate"
        } else if uvIndex <= 7 {
            return "High"
        } else if uvIndex <= 10 {
            return "Very High"
        } else {
            return "Extreme"
        }
    }
}

struct UVIndexBar: View {
    var uvIndex: Int
    
    var body: some View {
        Rectangle()
            .foregroundColor(getUVIndexColor(uvIndex))
    }
    
    private func getUVIndexColor(_ uvIndex: Int) -> Color {
        // Same color logic as in the HourlyForecastView
        if uvIndex <= 2 {
            return Color.green
        } else if uvIndex <= 5 {
            return Color.yellow
        } else if uvIndex <= 7 {
            return Color.orange
        } else if uvIndex <= 10 {
            return Color.red
        } else {
            return Color.purple
        }
    }
}

struct WeatherView: View {
    var uvIndex: Int
    var hourlyUVIndices: [Int]
    
    var body: some View {
        VStack {
            Text("UV Index Forecast")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("\(uvIndex)")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(getUVIndexColor(uvIndex))
                .padding(.top, 20)
            
            Text(getUVIndexDescription(uvIndex))
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding(.top, 10)
            
            HourlyForecastView2(hourlyUVIndices: hourlyUVIndices)
            
            Spacer()
        }
        .padding()
    }
    
    private func getUVIndexColor(_ uvIndex: Int) -> Color {
        // Same color logic as in the HourlyForecastView
        if uvIndex <= 2 {
            return Color.green
        } else if uvIndex <= 5 {
            return Color.yellow
        } else if uvIndex <= 7 {
            return Color.orange
        } else if uvIndex <= 10 {
            return Color.red
        } else {
            return Color.purple
        }
    }
    
    private func getUVIndexDescription(_ uvIndex: Int) -> String {
        // Same description logic as in the HourlyForecastView
        if uvIndex <= 2 {
            return "Low"
        } else if uvIndex <= 5 {
            return "Moderate"
        } else if uvIndex <= 7 {
            return "High"
        } else if uvIndex <= 10 {
            return "Very High"
        } else {
            return "Extreme"
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(uvIndex: 6, hourlyUVIndices: [3, 5, 7, 8, 9, 7, 6, 5, 4, 3])
    }
}
