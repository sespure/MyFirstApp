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
                                .ghostButton(width: 170)
                            }
                        
                        Button {
                            let saveTitle = title
                            saveTitle.title = titleName
                            modelContext.insert(saveTitle)
                            try? modelContext.save()
                        } label: {
                            Text(Constants.favoriteString)
                                .ghostButton(width: 120)
                        }
                        
                        Spacer()
                        
                    }
                }
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
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
