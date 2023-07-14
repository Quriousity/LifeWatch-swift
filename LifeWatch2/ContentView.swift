//
//  ContentView.swift
//  TextTest
//
//  Created by Q on 2023/07/13.
//
import Foundation
import SwiftUI
import WidgetKit

struct ContentView: View {
    @State var life = ""
    @State var life2 = "(Years)"

    @State var date = Date()
    @State private var isButtonVisible = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Life Watch")
                .font(.title)
                .fontWeight(.bold)
                .padding(10)
            TextField(life2, text: $life)
                .keyboardType(.decimalPad)
                .padding(.horizontal, 60)
                .padding(.vertical, 10)
            Button("Start", action: {
                hideKeyboard()
                isButtonVisible = true
                date = Calendar.current.date(byAdding: .year, value: Int(life)!, to: Date())!
                if let userDefaults = UserDefaults(suiteName: "group.com.LifeWatch230628") {
                    userDefaults.set(life, forKey: "a")
                    WidgetCenter.shared.reloadAllTimelines()
                }
                self.life = ""
            })
                .padding(10)
            if isButtonVisible {
                    Text(date, style: .timer)
                        .foregroundColor(Color.red)
                        .font(.custom("Seven Segment", size: 20))
                }
            Spacer()

        }
        .contentShape(Rectangle())
        .onTapGesture{ hideKeyboard() }
    }


    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
