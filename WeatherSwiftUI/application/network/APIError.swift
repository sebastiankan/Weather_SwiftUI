//
//  APIError.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/31/21.
//

import Foundation

enum APIError: String, Error {
    case invalidURL = "Invalid url"
    case failed = "Failed"
    case invalidResponse = "Invalid response"
    case invalidData = "Invalid data"
    case general = "General error"
}
