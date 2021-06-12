//
//  WeatherSwiftUIApp.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/29/21.
//

import SwiftUI

@main
struct WeatherSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
    
    static func setupColorScheme(isDark: Bool) {
        // We do this via the window so we can access UIKit components too.
        let window = UIApplication.shared.windows.first
        window?.overrideUserInterfaceStyle = isDark ? .dark : .light
        print(window?.overrideUserInterfaceStyle.rawValue)
    }
}
