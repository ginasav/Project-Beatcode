//
//  BookModel.swift
//  Project-Beatcode
//
//  Created by Gina Saviano on 04/07/25.
//

///I will create a class for books I've read this month.
///I will decorate it with @Model macro to make it work with SwiftData

import SwiftData
import Foundation

@Model
class BookModel {
    var id: UUID
    var title: String
    var author: String
    var isFavorite: Bool
    
    init(title: String, author: String) {
        self.id = UUID()
        self.title = title
        self.author = author
        self.isFavorite = false
    }
}
