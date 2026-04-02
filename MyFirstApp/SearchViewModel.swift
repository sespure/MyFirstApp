//
//  SearchViewModel.swift
//  MyFirstApp
//
//  Created by sespure on 01.04.2026.
//

import Foundation

@Observable
class SearchViewModel {
    private(set) var errorMassage: String?
    private(set) var searchTitles: [Title] = []
    private var dataFetcher = DataFetcher()
    
    func getSearchTitles(by media: String, for title: String) async {
        do {
            errorMassage = nil
            if title.isEmpty {
                searchTitles = try await dataFetcher.fetchTitles(for: media, by: "trending")
            } else {
                searchTitles = try await dataFetcher.fetchTitles(for: media, by: "search", with: title)
            }
        } catch {
            print(error)
            errorMassage = error.localizedDescription
        }
    }
}
