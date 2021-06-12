//
//  ForecastDay.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 6/7/21.
//

import Foundation
import SwiftyJSON

struct ForecastDay: Identifiable {
    let id = UUID()
    var dateEpoch: Double
    var day: Day
    var hours: [Hour] = []
    
    init(json: JSON) {
        dateEpoch = json["date_epoch"].doubleValue
        day = Day(json: json["day"])
        hours = json["hour"].arrayValue.map({Hour(json: $0)})
    }
    
}
