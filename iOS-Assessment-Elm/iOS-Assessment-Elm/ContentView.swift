//
//  ContentView.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 18/03/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @Binding var selectedTab: Int  
    
    var body: some View {
        TabView(selection: $selectedTab) {
            UsersView()
                .tabItem {
                    Label("Users", systemImage: "person.3.fill")
                }
                .tag(0)
            
            CalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "plus.slash.minus")
                }
                .tag(1)
        }
    }
}
