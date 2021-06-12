//
//  APIUrls.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/31/21.
//

import Foundation

struct API {
    static private let baseURL = "https://api.weatherapi.com/v1/"
    
    struct URLs {
        static let forecast = API.baseURL + "forecast.json"
    }
}
