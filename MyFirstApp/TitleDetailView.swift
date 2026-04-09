//
//  TitleDetailView.swift
//  MyFirstApp
//
//  Created by sespure on 21.03.2026.
//

import SwiftUI
import SwiftData

struct TitleDetailView: View {
    let title: Title
    @State private var isSaved = false

    var titleName : String {
        return (title.name ?? title.title) ?? ""
    }
    
    let viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .overlay (
                                LinearGradient(stops: [
                                    .init(color: Color.gradient.opacity(1.1), location: 0),
                                    .init(color: .clear, location: 0.25),
                                    .init(color: .clear, location: 0.75),
                                    .init(color: Color.gradient.opacity(1.1), location: 1)
                                ], startPoint: .top, endPoint: .bottom)
                            )
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                    
                    Text((title.name ?? title.title) ?? "")
                        .bold()
                        .font(.title2)
                        .padding(5)
                    
                    Text(title.overview ?? "")
                        .padding(5)
                    
                    HStack {
                        Spacer()

                        Button(action: {
                            let movieName = (title.name ?? title.title) ?? ""
                            if let url = getMovieSearchURL(movieTitle: movieName) {
                                openURL(url)
                            }
                        }) {
                            Text("Watch")
                                .ghostButton(width: 300)
                        }

                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing)  {
                    Button {
                        if isSaved == false {
                            saveToFavorites()
                        } else {
                            removeFromFavorites()
                        }
                    } label: {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                    }
                }
            }
            .task {
                isSaved = isAlreadySaved()
            }
        }
    }
    
    private func getMovieSearchURL(movieTitle: String) -> URL? {
        guard !movieTitle.isEmpty else { return nil }
        
        let baseURL = "https://uakino.best/index.php?do=search&subaction=search&story="
        
        guard let encodedQuery = movieTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        return URL(string: baseURL + encodedQuery)
    }

    private func saveToFavorites() {
        guard !isAlreadySaved() else {
            isSaved = true
            return
        }

        let savedTitle = Title(
            id: title.id,
            title: titleName,
            name: title.name ?? title.title,
            overview: title.overview,
            posterPath: title.posterPath
        )

        modelContext.insert(savedTitle)
        try? modelContext.save()
        isSaved = true
    }

    private func removeFromFavorites() {
        guard let savedTitle = fetchSavedTitle() else {
            isSaved = false
            return
        }

        modelContext.delete(savedTitle)
        try? modelContext.save()
        isSaved = false
    }

    private func isAlreadySaved() -> Bool {
        fetchSavedTitle() != nil
    }

    private func fetchSavedTitle() -> Title? {
        guard let titleID = title.id else {
            return nil
        }

        let descriptor = FetchDescriptor<Title>(
            predicate: #Predicate { savedTitle in
                savedTitle.id == titleID
            }
        )

        return try? modelContext.fetch(descriptor).first
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[1])
}
