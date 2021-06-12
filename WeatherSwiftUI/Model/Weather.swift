//
//  Weather.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/31/21.
//

import Foundation
import SwiftyJSON

struct Weather {
    let city: String
    let temp: Int
    let condition: String
    let icon: String
    let isDay: Bool
    var hours: [Hour] = []
    
    init(json: JSON) {
        city = json["location"]["name"].stringValue
        temp = json["current"]["temp_c"].intValue
        condition = json["current"]["condition"]["text"].stringValue
        icon = json["current"]["condition"]["icon"].url?.pathComponents.last?.replacingOccurrences(of: ".png", with: "") ?? ""
        isDay = json["current"]["is_day"].boolValue
        if let firstForcastDay = json["forecast"]["forecastday"].arrayValue.first {
            hours = firstForcastDay["hour"].arrayValue.map({Hour(json: $0)})
        }
        
    }
}
