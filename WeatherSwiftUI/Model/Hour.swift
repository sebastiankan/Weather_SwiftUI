//
//  WeekDay.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/29/21.
//

import Foundation
import SwiftyJSON

struct Hour: Identifiable {
    var id = UUID()
    let time: String
    let temp: Double
    let condition: String
    let icon: String
    let isDay: Bool
    
    init(json: JSON) {
        temp = json["temp_c"].doubleValue
        condition = json["current"]["condition"]["text"].stringValue
        icon = json["condition"]["icon"].url?.pathComponents.last?.replacingOccurrences(of: ".png", with: "") ?? ""
        isDay = json["is_day"].boolValue
        time = json["time"].stringValue
    }
    
}
