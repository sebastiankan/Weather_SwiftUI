//
//  HomeHeaderView.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/29/21.
//

import SwiftUI

struct HomeHeaderView: View {
    @Binding var weather: Weather?
    
    var body: some View {
            VStack {
                Text("\(weather?.temp ?? 0)°")
                    .font(.system(size: 26))
                    .foregroundColor(Color.white)
                Image(weather?.icon ?? "")
                Label(
                    title: { Text(weather?.condition ?? "Unavailable") },
                    icon: { Image(systemName: "") }
                ).foregroundColor(.white)
            }

        
    }
    
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(weather: .constant(nil))
    }
}
