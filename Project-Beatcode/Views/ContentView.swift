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

struct ContentView: View {
    @State var viewModel: BooksViewModel
    
    var body: some View {
        VStack {
            ForEach (viewModel.books) { book in
                HStack {
                    Text(book.title)
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: BooksViewModel())
}
