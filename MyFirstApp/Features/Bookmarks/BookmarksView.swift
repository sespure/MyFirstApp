//
//  DownloadView.swift
//  MyFirstApp
//
//  Created by sespure on 02.04.2026.
//

import SwiftUI
import SwiftData

struct BookmarksView: View {
    @Query(sort: \Title.title) var savedTitles: [Title]
    
    
    var body: some View {
        NavigationStack {
            if savedTitles.isEmpty {
                Text("No bookmarks yet")
                    .padding()
                    .font(.title3)
                    .bold()
            } else {
                VerticalListView(titles: savedTitles, canDelete: true)
            }
        }
    }
}

#Preview {
    BookmarksView()
}
