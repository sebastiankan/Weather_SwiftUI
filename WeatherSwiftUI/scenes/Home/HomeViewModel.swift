//
//  HomeViewModel.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/30/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var weather: Weather? {
        willSet { objectWillChange.send() }
    }
    
    @Published var ForecastDays: [ForecastDay] = [] {
        willSet { objectWillChange.send() }
    }
    
    func getWeather(cityName: String, success: @escaping (Bool)-> Void) {
        let params: [String: Any] = [
            "key": "06a7c8c3b527432fb1142703213105",
            "q": cityName,
            "days": 7,
            "api": "no",
            "alert": "no"
        ]
        NetworkManager.callAPI(urlString: API.URLs.forecast, params: params) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let json):
                self.weather = Weather(json: json)
                self.ForecastDays = json["forecast"]["forecastday"].arrayValue.map({ForecastDay(json: $0)})
                WeatherSwiftUIApp.setupColorScheme(isDark: !(self.weather?.isDay ?? true))
                success(true)
                break
            
            case .failure(let error):
                print(error.rawValue)
                success(false)
                break
                
            }
        }
    }
}
