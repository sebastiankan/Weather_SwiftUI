//
//  HomeView.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/29/21.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @State var isSearchPresented: Bool = false
    @State var cityName: String = "Sanandaj"
    
    var body: some View {
        
        GeometryReader(content: { geometry in
                ZStack {
                    ZStack {
                        Image("wallpaper").resizable().opacity(0.77)
    //                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        VStack {
                            ZStack {
                                HStack {
                                    Spacer()
                                    Text(viewModel.weather?.city ?? "")
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                HStack {
                                    Button(action: {
                                        self.isSearchPresented.toggle()
                                    }, label: {
                                        Image(systemName: "magnifyingglass")
                                            .padding(12)
                                            .foregroundColor(.white)
                                    })
                                    Spacer()
                                }
                                
                            }
                            VStack {
                                
                                HomeHeaderView(weather:
                                                .init(
                                                    get: { self.viewModel.weather },
                                                    set: { viewModel.weather = $0 }))
                                
                                HomeTodayView(weather:
                                                .init(
                                                get: { self.viewModel.weather },
                                                set: { viewModel.weather = $0 }))
                                
                                List {
                                    ForEach(viewModel.ForecastDays, id: \.id) { forecastDay in
                                        DayCell(forecastDay: forecastDay)
                                    }
                                }
                                                                
                                TabView {
                                    ForEach(0..<3) { index in
                                        GeometryReader { geo in
                                            switch index {
                                            case 0:
                                                HomeTabItem {
                                                    LineChartView(data: viewModel.weather != nil ? $viewModel.weather.wrappedValue!.hours.map({$0.temp}) : [10, 13, 15, 9], title: "Daily temp",
                                                                  style: ChartStyle(backgroundColor: .clear, accentColor: .red, gradientColor: GradientColor(start: .green, end: .purple), textColor: .white, legendTextColor: .white, dropShadowColor: .clear),
                                                                  form: ChartForm.large,
                                                                  dropShadow: false)
                                                }
                                                
                                            case 1:
                                                HomeTabItem {
                                                    Text("Page 2")
                                                }
                                            case 2:
                                                HomeTabItem {
                                                    Text("Page 3")
                                                }
                                            default:
                                                Text("Unknown index: \(index)")
                                            }
                                        }
                                        
                                    }
                                    
                                }.tabViewStyle(PageTabViewStyle())
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                                .frame(width: geometry.size.width, height: geometry.size.height / 4, alignment: .center)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                                }
                            .padding(EdgeInsets(top: geometry.safeAreaInsets.top, leading: 0, bottom: 0, trailing: 0))
                        }
                        .padding(EdgeInsets(top: geometry.safeAreaInsets.top, leading: 0, bottom: 0, trailing: 0))
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                }
                .ignoresSafeArea(.all)
                .sheet(isPresented: $isSearchPresented, content: {
                    SearchView(selectedCity: $cityName.didSet(execute: { string in
                        self.viewModel.getWeather(cityName: string, success: { _ in })
                    }))
            })
        }).onAppear(perform: {
            Theme.apply()
            fetch()
        })
    }
    
    fileprivate func fetchWeather() {
        if let string = viewModel.weather?.city {
            viewModel.getWeather(cityName: string, success: { _ in })
        }
    }
    
    func fetch() {
        viewModel.getWeather(cityName: "Sanandaj") { isSuccesful in }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension ScrollView {
    
    public func fixFlickering() -> some View {
        
        return self.fixFlickering { (scrollView) in
            
            return scrollView
        }
    }
    
    public func fixFlickering<T: View>(@ViewBuilder configurator: @escaping (ScrollView<AnyView>) -> T) -> some View {
        
        GeometryReader { geometryWithSafeArea in
            GeometryReader { geometry in
                configurator(
                ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
                    AnyView(
                    VStack {
                        self.content
                    }
                    .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
                    .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
                    .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
                    .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
                    )
                }
                )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct HomeTabItem<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        
        GeometryReader { geometry in
            content
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                   Image(systemName: "house.fill")
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .background(Color("hourCardBack"))
                .cornerRadius(24)
        }.padding(EdgeInsets(top: 0, leading: 12, bottom: 8, trailing: 12))
        .foregroundColor(.white)
        
    }
}
