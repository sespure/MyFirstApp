//
//  Constants.swift
//  MyFirstApp
//
//  Created by sespure on 15.03.2026.
//

import Foundation
import SwiftUI

struct Constants {
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let bookmarkString = "Bookmarks"
    static let playString = "Play"
    static let trendingMovieString = "Trending Movie"
    static let trendingTVSString = "Trending Tv"
    static let topRatedMoviesString = "Top Rated Movies"
    static let topRatedTVSString = "Top Rated TV"
    static let movieSearchString = "Movie Search"
    static let tvSearchString = "TV Search"
    static let moviePlaceholderString = "Search for a movie"
    static let tvPlaceholderString = "Search for a tv show"
    
    static let homeIconString = "house.fill"
    static let upcomingIconString = "play.fill"
    static let searchIconString = "magnifyingglass"
    static let bookmarkIconString = "bookmark.fill"
    static let tvIconString = "tv.fill"
    static let movieIconString = "movieclapper.fill"
    
    
    static let testTitleURL = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath (to titles: inout[Title]) {
        for index in titles.indices {
            if let path = titles[index].posterPath {
                titles[index].posterPath = Constants.posterURLStart + path
            }
        }
    }
}

extension View {
    func buttonLabel(
        width: CGFloat = 100,
        height: CGFloat = 50,
        font: Font = .body
    ) -> some View {
        self
            .font(font)
            .frame(width: width, height: height)
            .foregroundStyle(.buttonText)
            .bold()
    }
}

extension Text {
    func errorMessage() -> some View {
        self
            .foregroundStyle(.red)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))
    }
}
