//
//  DictionaryExtensions.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/31/21.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
