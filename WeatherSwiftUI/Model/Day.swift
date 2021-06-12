//
//  Day.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 6/7/21.
//

import Foundation
import SwiftyJSON

struct Day: Identifiable {
    var id = UUID()
    let time: String
    let maxTemp: Int
    let minTemp: Int
    let condition: String
    let icon: String
    let isDay: Bool
    
    init(json: JSON) {
        maxTemp = json["maxtemp_c"].intValue
        minTemp = json["mintemp_c"].intValue
        condition = json["condition"]["text"].stringValue
        icon = json["condition"]["icon"].url?.pathComponents.last?.replacingOccurrences(of: ".png", with: "") ?? ""
        isDay = json["is_day"].boolValue
        time = json["time"].stringValue
    }
    
}
