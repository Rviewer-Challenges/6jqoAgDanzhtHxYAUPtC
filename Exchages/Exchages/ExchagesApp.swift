//
//  ExchagesApp.swift
//  Exchages
//
//  Created by Dario Gallegos on 12/10/22.
//

import SwiftUI

@main
struct ExchagesApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .environmentObject(viewModel)
        }
    }
}
