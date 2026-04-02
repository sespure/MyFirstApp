//
//  HomeView.swift
//  MyFirstApp
//
//  Created by sespure on 15.03.2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    let viewModel = ViewModel()
    @State private var titleDetailPath = NavigationPath()
    @Environment(\.modelContext) var modelcontext
        
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader { geo in
                ScrollView {
                    switch self.viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        LazyVStack {
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")){ image in
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
                            .frame(width: geo.size.width, height: geo.size.height * 0.85)
                            HStack {
                                Button {
                                    titleDetailPath.append(viewModel.heroTitle)
                                } label: {
                                    Text("Details")
                                        .ghostButton(width: 350, height: 50, font: .title3)
                                }
                            }
                            
                            HorizontalListView(header: Constants.trendingMovieString, titles: viewModel.trendingMovies) {title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.trendingTVSString, titles: viewModel.trendingTV) {title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedMoviesString, titles: viewModel.topRatedMovies) {title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedTVSString, titles: viewModel.topRatedTV) {title in
                                titleDetailPath.append(title)
                            }
                        }
                    
                    case .failed(let error):
                        Text(error.localizedDescription)
                            .errorMassage()
                            .frame(width: geo.size.width, height: geo.size.height)
                        
                    }
                    
                }
                .task {
                    await viewModel.getTitles()
                }
                .navigationDestination(for: Title.self) { title in
                    TitleDetailView(title: title)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
