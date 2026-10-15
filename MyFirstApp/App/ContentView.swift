//
//  ContentView.swift
//  MyFirstApp
//
//  Created by sespure on 15.03.2026.
//

import SwiftUI
import Network

struct ContentView: View {
    @State private var networkMonitor = NWPathMonitor()
    @State private var showAlert = false
    @State private var hasStartedMonitoring = false

    var body: some View {
        TabView {
            Tab(Constants.homeString, systemImage: Constants.homeIconString) {
                HomeView()
            }
            Tab(Constants.upcomingString, systemImage: Constants.upcomingIconString) {
                UpcomingView()
            }
            Tab(Constants.bookmarkString, systemImage: Constants.bookmarkIconString) {
                BookmarksView()
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconString, role: .search) {
                SearchView()
            }
        }
        .onAppear {
            guard !hasStartedMonitoring else { return }
            hasStartedMonitoring = true

            networkMonitor.pathUpdateHandler = { path in
                let isDisconnected = path.status != .satisfied
                DispatchQueue.main.async {
                    showAlert = isDisconnected
                }
            }
            networkMonitor.start(queue: DispatchQueue.global(qos: .background))
        }
        .onDisappear {
            networkMonitor.cancel()
        }
        .alert("Network Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please check your internet connection")
        }
    }
}

#Preview {
    ContentView()
}
