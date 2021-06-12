//
//  SearchView.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/30/21.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    let cities = ["Sanandaj", "Tehran", "Hamedan", "Kermanshah", "London", "Los angeles", "Tokyo", "Moscow"]
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @Binding var selectedCity: String
    
    var body: some View {
        NavigationView{
            
            ZStack {
                List {
                    ForEach(self.cities.filter {
                        self.searchBar.text.isEmpty ? true : $0.lowercased().contains(self.searchBar.text.lowercased())
                    }, id: \.self) { city in
                        HStack {
                            Text(city)
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width * 0.9, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            selectedCity = city
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .navigationBarTitle(Text("Cities"))
                .add(self.searchBar)
                .navigationTitle("Search Bar App")

            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(selectedCity: .constant(""))
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

extension Binding {
    /// Execute block when value is changed.
    ///
    /// Example:
    ///
    ///     Slider(value: $amount.didSet { print($0) }, in: 0...10)
    func didSet(execute: @escaping (Value) ->Void) -> Binding {
        return Binding(
            get: {
                return self.wrappedValue
            },
            set: {
                self.wrappedValue = $0
                execute($0)
            }
        )
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
