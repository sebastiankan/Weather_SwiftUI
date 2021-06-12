//
//  HomeTodayView.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/29/21.
//

import SwiftUI

struct HomeTodayView: View {
    @Binding var weather: Weather?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 4) {
                ForEach(weather?.hours ?? [], id: \.id) { hour in
                    VStack {
                        
                        Text(Utility.timeFormat(Utility.formatDate(string: hour.time)))
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                        
                        Image(hour.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        Text("\(hour.temp, specifier: "%.1f")°")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        
                    }
                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: 112, alignment: .center)
                    .background(Color("hourCardBack"))
                    .cornerRadius(4)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        

    }
}

struct HomeDaysView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTodayView(weather: .constant(nil))
    }
}
