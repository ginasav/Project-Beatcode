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
        NavigationView {
            VStack {
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
            }
        }
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
    BookDetailView(
        book: BookModel(title: "Sample Book",
                        author: "Sample Author")
    )
}
