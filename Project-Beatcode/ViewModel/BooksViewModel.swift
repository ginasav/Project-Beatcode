//
//  BooksViewModel.swift
//  Project-Beatcode
//
//  Created by Gina Saviano on 04/07/25.
//

///Here I'll insert the logic for SwiftData to work. So:
///- set ModelContext to observe all the changes on my data - DONE
///- fetch Data
///- save Context - DONE
///- mock data - DONE
///- make the mock data @Observable, so it can handle the changes in the UI when the data changes based on the user input - DONE
///- favorite function

import SwiftData
import Foundation

@Observable
class BooksViewModel {
    var books: [BookModel] = [] //the array that will contain data fetched, retrieved, saved, changed, etc.
    private var modelContext: ModelContext?
    
    //since SwiftData doesn't work well with MVVM, I'll inject "manually" the ModelContext
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
        //func to initialze data
    }
    
    ///I'll create a function to:
    ///1. check if the data is already there
    ///2. inject the mock data
    
    private func initializeDataIfNeeded() {
        //1. Check if data is already there
        let descriptor = FetchDescriptor<BookModel>() //query to fetch all the instances of BookModel
        let existingBooks = try? modelContext?.fetch(descriptor) ?? []
        
        //2. If not, inject mock data
        if existingBooks?.isEmpty == true {
            let mockBooks: [BookModel] = [
                .init(title: "Noi due ci apparteniamo", author: "Roberto Saviano"),
                .init(title: "God save the queer", author: "Michela Murgia"),
                .init(title: "Strani disegni", author: "Uketsu"),
            ]
            
            mockBooks.forEach { item in
                modelContext?.insert(item)
            }
            
            try? modelContext?.save()
        }
    }
    
    //since I can't use @Query - which automatically populates the array books - I'll create a fetch function
    func fetchBooks() {
        guard let modelContext = modelContext else { return }
        
        do {
            let descriptor = FetchDescriptor<BookModel>()
            books = try modelContext.fetch(descriptor)
        } catch {
            print ("Fetch failed : \(error)")
            books = []  //Go back to the empty array
        }
    }
}
