//
//  BookDetailView.swift
//  Project-Beatcode
//
//  Created by Gina Saviano on 06/07/25.
//

//Here I need to show the title and the favorite info when I tap the title in the ContentView

import SwiftUI

struct BookDetailView: View {
    let book: BookModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
                //Book Icon
                Image(systemName: "book.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.cyan)
                
                //Book Details
                VStack {
                    Text(book.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("by \(book.author)")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                
                // Favorite Status
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(book.isFavorite ? .red : .gray)
                            .font(.title2)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .navigationTitle("Book Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button ("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationView{
        BookDetailView(
            book: BookModel(title: "Sample Book",
                            author: "Sample Author")
        )
    }
}
