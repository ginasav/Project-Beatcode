//
//  ContentView.swift
//  Project-Beatcode
//
//  Created by Gina Saviano on 04/07/25.
//

///WHAT I NEED TO DO:
///Main part:
///- a list of cells with different titles (something simple like "Cell number X")
///- an icon/button to mark the item as favorite or remove it from favorite WITH A TAP
///- if I tap on the cell - excluding the favorite button -  a detail view open up with the same features as the cell (title and favorite button) (maybe a modal??)
///- the favorite status should remain synchronized between the list and the detail view
///
///Extra part:
///- the UI
///- make the app accessible

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = BooksViewModel()
    @State private var selectedBook: BookModel?
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [
                        Color(.systemBackground),
                        Color(.systemGray6).opacity(0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach (viewModel.books) { book in
                            BookCardView(
                                book: book,
                                onTap: { selectedBook = book },
                                onFavoriteToggle: { viewModel.toggleFavorite(for: book) }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
            }
            .navigationTitle("Books of the month")
        }
        //adding onAppear to load the modelContext
        .onAppear{
            viewModel.setModelContext(modelContext)
        }
        .sheet(item: $selectedBook) { book in
            BookDetailView(bookID: book.id, viewModel: viewModel)
        }
    }
}


//MARK: - BOOK CARD COMPONENT
struct BookCardView: View {
    let book: BookModel
    let onTap: () -> Void
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Book Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                colors: [.blue.opacity(0.8),
                                         .purple.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 80)
                    
                    Image(systemName: "book.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                
                //Book info
                VStack(alignment: .leading, spacing: 8) {
                    Text(book.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text("by \(book.author)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                //Favorite Button
                Button(action: onFavoriteToggle) {
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundStyle(book.isFavorite ? .red : .gray)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    ContentView()
        .modelContainer(for: BookModel.self, inMemory: true)
}
