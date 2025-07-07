//
//  BookDetailView.swift
//  Project-Beatcode
//
//  Created by Gina Saviano on 06/07/25.
//

//Here I need to show the title and the favorite info when I tap the title in the ContentView

import SwiftUI

struct BookDetailView: View {
    let bookID: UUID
    let viewModel: BooksViewModel
    @Environment(\.dismiss) var dismiss
    
    private var book: BookModel? {
        viewModel.books.first { $0.id == bookID }
    }
    
    var body: some View {
        ZStack{
            //Background gradient
            LinearGradient(
                colors: [
                    Color(.systemGray2).opacity(0.3),
                    Color(.systemGray6).opacity(0.6)
                ],
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
            .ignoresSafeArea()
            .accessibilityHidden(true)
            
            //Blur
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(0.7)
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack(spacing: 10) {
                if let book = book {
                    //Book Icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    colors: [.blue.opacity(0.8),
                                             .purple.opacity(0.6)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white.opacity(0.4), lineWidth: 1.5)
                            }
                            .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 8)
                        
                        Image(systemName: "book.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 20)
                    .accessibilityLabel("Book cover for \(book.title)")
                    .accessibilityAddTraits(.isImage)
                    
                    //Book Details Card
                    VStack {
                        Text(book.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("by \(book.author)")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                    .padding(30)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.regularMaterial)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white.opacity(0.4), lineWidth: 1.5)
                            }
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 8)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Book Details: \(book.title) by \(book.author)")
                    .accessibilityAddTraits(.isStaticText)
                    
                    // Favorite Status Card
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(book.isFavorite ? .red : .gray)
                                .font(.title2)
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.regularMaterial)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.white.opacity(0.4), lineWidth: 1.5)
                                }
                                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        }
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Favorite status: \(book.isFavorite ? "This book is in your favorites" : "This book is not in your favorites")")
                    .accessibilityAddTraits(.isStaticText)
                } else {
                    ProgressView("Loading...")
                        .accessibilityLabel("Loading book details")
                        .accessibilityAddTraits(.updatesFrequently)
                }
            }
        }
            .navigationTitle("Book Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button ("Done") {
                    dismiss()
                }
                .accessibilityLabel("Close book details")
                .accessibilityHint("Double tap to return to the book list")
                .accessibilityAddTraits(.isButton)
            }
        }
            .accessibilityAction(named: "Close") {
                dismiss()
            }
    }
}

#Preview {
    NavigationView{
        BookDetailView(bookID: UUID(), viewModel: BooksViewModel())
    }
}
