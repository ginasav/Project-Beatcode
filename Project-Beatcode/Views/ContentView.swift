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
    @State private var showingDetail = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (viewModel.books) { book in
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(book.title)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundStyle(.primary)
                                .onTapGesture {
                                    selectedBook = book
                                    showingDetail = true
                                }
                            
                            Text("by \(book.author)")
                                .font(.caption)
                        }
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleFavorite(for: book)
                        }) {
                            Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(book.isFavorite ? .red : .gray)
                        }
                        .buttonStyle(PlainButtonStyle()) //to prevent button from capturing row taps
                    }
                    .padding(.horizontal)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Books of this month")
        }
        //adding onAppear to load the modelContext
        .onAppear{
            viewModel.setModelContext(modelContext)
        }
        .sheet(isPresented: $showingDetail) {
            if let selectedBook = selectedBook {
                BookDetailView(book: selectedBook)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: BookModel.self, inMemory: true)
}
