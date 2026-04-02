//
//  ContentView.swift
//  MyFirstApp
//
//  Created by sespure on 15.03.2026.
//

import SwiftUI
// test
struct ContentView: View {
    var body: some View {
        TabView{
            Tab(Constants.homeString,systemImage: Constants.homeIconStrint) {
                HomeView()
            }
            Tab(Constants.upComigString,systemImage: Constants.upComigIconStrint) {
                UpcomingView()
            }
            Tab(Constants.downloadString,systemImage: Constants.downloadIconString) {
                DownloadView()
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconStrint, role: .search) {
                SearchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
