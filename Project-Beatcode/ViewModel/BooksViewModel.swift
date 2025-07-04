//
//  BooksViewModel.swift
//  Project-Beatcode
//
//  Created by Gina Saviano on 04/07/25.
//

///Here I'll insert the logic for SwiftData to work. So:
///- set ModelContext to observe all the changes on my data - DONE
///- fetch Data
///- save Context
///- mock data
///- make the mock data @Observable, so it can handle the changes in the UI when the data changes based on the user input

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
    
    
}
