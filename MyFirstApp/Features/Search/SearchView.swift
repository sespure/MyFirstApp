//
//  SearchView.swift
//  MyFirstApp
//
//  Created by sespure on 30.03.2026.
//

import SwiftUI

struct SearchView: View {
    @State private var searchByMovies = true
    @State private var searchText = ""
    @State private var searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()

    private var selectedMedia: String {
        searchByMovies ? "movie" : "tv"
    }

    private var searchTaskID: String {
        "\(selectedMedia)-\(searchText)"
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                if let error = searchViewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(searchViewModel.searchTitles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")) {
                            image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 15))
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                        .onTapGesture {
                            navigationPath.append(title)
                        }
                    }
                }
            }
            .navigationTitle(searchByMovies ?
                             Constants.movieSearchString : Constants.tvSearchString)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        searchByMovies.toggle()
                    } label: {
                        Image(systemName: searchByMovies ?
                              Constants.movieIconString : Constants.tvIconString)
                    }
                }
            }
            .searchable(text: $searchText, prompt: searchByMovies ? Constants.moviePlaceholderString: Constants.tvPlaceholderString)
            .task(id: searchTaskID) {
                try? await Task.sleep(for: .milliseconds(500))
                
                if Task.isCancelled {
                    return
                }
                
                await searchViewModel.getSearchTitles(by: selectedMedia, for: searchText)
            }
            .navigationDestination(for: Title.self) { title in
                TitleDetailView(title: title)
            }
        }
    }
}



#Preview {
    SearchView()
}
