//
//  VerticalListView.swift
//  MyFirstApp
//
//  Created by sespure on 24.03.2026.
//

import SwiftUI
import SwiftData

struct VerticalListView: View {
    var titles: [Title]
    let canDelete: Bool
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List(titles) { title in
            NavigationLink {
                TitleDetailView(title: title)
            } label: {
                AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                    HStack {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(10)
                        
                        Text((title.name ?? title.title) ?? "")
                            .font(.system(size: 16))
                            .bold()
                    }
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 170)
            }
            
            .swipeActions(edge: .trailing) {
                if canDelete {
                    Button() {
                        modelContext.delete(title)
                        try? modelContext.save()
                    } label: {
                        Image(systemName: "trash.fill")
                            .tint(.red)
                    }
                } else {
                    
                }
            }
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles, canDelete: true)
}
