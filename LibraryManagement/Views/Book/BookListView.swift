//
//  BookListView.swift
//  LibraryManagement
//
//  Created by Nuzulul Salsabila on 23/11/24.
//
import SwiftUI
struct BookListView: View {
    @StateObject private var bookViewModel = BookViewModel()
    @State private var isAddingBook = false

    var body: some View {
        NavigationView {
            List {
                ForEach(bookViewModel.books, id: \.id) { book in
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text("Author: \(book.author)")
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteBook)
            }
          
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingBook.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingBook) {
                AddBookView(bookViewModel: bookViewModel)
            }
        }
    }

    private func deleteBook(at offsets: IndexSet) {
        offsets.forEach { index in
            let bookID = bookViewModel.books[index].id
            bookViewModel.deleteBook(bookID: bookID)
        }
    }
}
