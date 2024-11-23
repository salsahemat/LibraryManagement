//
//  AddBookView.swift
//  LibraryManagement
//
//  Created by Nuzulul Salsabila on 23/11/24.
//

import SwiftUI
struct AddBookView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var bookViewModel: BookViewModel
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var selectedCategoryIDs: [Int32] = []
    var book: Book? // Optional Book for editing

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                }
                
                Section(header: Text("Categories")) {
                    List(categoryViewModel.categories, id: \.id) { category in
                        MultipleSelectionRow(
                            title: category.name,
                            isSelected: selectedCategoryIDs.contains(category.id)
                        ) {
                            if selectedCategoryIDs.contains(category.id) {
                                selectedCategoryIDs.removeAll { $0 == category.id }
                            } else {
                                selectedCategoryIDs.append(category.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle(book == nil ? "Add Book" : "Edit Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(book == nil ? "Save" : "Update") {
                        saveOrUpdateBook()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty || author.isEmpty)
                }
            }
            .onAppear {
                categoryViewModel.fetchCategories()
                if let book = book {
                    title = book.title
                    author = book.author
                    selectedCategoryIDs = book.categories.map { $0.id }
                }
            }
        }
    }

    private func saveOrUpdateBook() {
        if let book = book {
            bookViewModel.updateBook(bookID: book.id, title: title, author: author)
            // Update categories
            selectedCategoryIDs.forEach { categoryID in
                SQLiteManager.shared.addBookToCategory(bookID: book.id, categoryID: categoryID)
            }
        } else {
            let bookID = bookViewModel.addBook(title: title, author: author)
            selectedCategoryIDs.forEach { categoryID in
                SQLiteManager.shared.addBookToCategory(bookID: bookID, categoryID: categoryID)
            }
        }
        bookViewModel.fetchBooks() // Refresh books after adding or updating
    }
}
