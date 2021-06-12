//
//  Theme.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/30/21.
//

import Foundation
import SwiftUI

enum Theme {
    
    static func apply() {
        UINavigationController.applyTheme()
    }
}

extension UINavigationController {
    
    static func applyTheme() {
//        applyNavigationBarTheme()
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().tableFooterView = UIView()
    }
    
    
    // NavigationBar
    private static func applyNavigationBarTheme() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.monospacedSystemFont(ofSize: 36, weight: .black)
        ]

        appearance.largeTitleTextAttributes = attrs

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

}
