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
                LinearGradient(
                    colors: [
                        Color(.black).opacity(0.4),
                        Color(.systemGray6).opacity(0.6)
                    ],
                    startPoint: .bottomTrailing,
                    endPoint: .topLeading
                )
                .ignoresSafeArea()
                .accessibilityHidden(true) //Hide the background for the VoiceOver
                
                //Little bit of blur
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(0.7)
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                    
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
                        .navigationTitle("Books of the month")
                    }
                    .scrollDisabled(true)
                }
            }
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
        @State private var isHeartPressed: Bool = false
        
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
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.white.opacity(0.4), lineWidth: 1.5)
                            }
                        
                        Image(systemName: "book.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    .accessibilityHidden(true)
                    
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
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("\(book.title) by \(book.author)")
                    
                    Spacer()
                    
                    //Favorite Button
                    Button(action: {
                        //Little animation when I tap on the heart
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isHeartPressed = true
                        }
                        
                        //Call the function to toggle the status
                        onFavoriteToggle()
                        
                        //Reset animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                isHeartPressed = false
                            }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 44, height: 44)
                                .overlay {
                                    Circle()
                                        .stroke(.white.opacity(0.4), lineWidth: 1)
                                }
                            
                            Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundStyle(book.isFavorite ? .red : .gray)
                                .scaleEffect(isHeartPressed ? 1.3 : 1.0)
                                .animation(.easeInOut(duration: 0.1), value: isHeartPressed)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityHidden(true)
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.regularMaterial)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white.opacity(0.4), lineWidth: 2)
                        }
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Book: \(book.title) by \(book.author). \(book.isFavorite ? "Currently favorited" : "Not favorited")")
            .accessibilityHint("Double tap to view book details. Use the rotor to access favorite actions")
            .accessibilityAddTraits(.isButton)
            //Custom VoiceOver Action to toggle favorites
            .accessibilityAction(named: book.isFavorite ? "Remove from Favorites" : "Add to Favorites") {
                onFavoriteToggle()
            }
            .accessibilityAction(named: "Toggle Favorite Status") {
                onFavoriteToggle()
            }
        }
    }
    
    
    #Preview {
        ContentView()
            .modelContainer(for: BookModel.self, inMemory: true)
    }
