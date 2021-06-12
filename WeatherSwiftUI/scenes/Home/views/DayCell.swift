//
//  DayCell.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 6/7/21.
//

import SwiftUI

struct DayCell: View {
    var forecastDay: ForecastDay?

    var body: some View {
        HStack {
            Text(Utility.dateFormat(unixtimeInterval: forecastDay?.dateEpoch ?? 0))
                .foregroundColor(.white)
            Spacer()
            Image(forecastDay?.day.icon ?? "")
                .resizable()
                .frame(width: 28, height: 28, alignment: .center)
            Spacer()
            Text("\(forecastDay?.day.maxTemp ?? -100)")
                .foregroundColor(.white)
            Spacer(minLength: 16)
            Text("\(forecastDay?.day.minTemp ?? -100)")
                .foregroundColor(.white.opacity(0.75))
            
        }
        .listRowBackground(Color("hourCardBack"))
    }
}

struct DayCell_Previews: PreviewProvider {
    static var previews: some View {
        DayCell(forecastDay: nil)
    }
}

