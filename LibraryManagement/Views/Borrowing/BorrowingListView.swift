//
//  BorrowingListView.swift
//  LibraryManagement
//
//  Created by Nuzulul Salsabila on 23/11/24.
//
import SwiftUI

struct BorrowingListView: View {
    @StateObject private var viewModel = BorrowingViewModel()
    @State private var showingAddView = false
    @State private var editingBorrowing: Borrowing? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.borrowings, id: \.id) { borrowing in
                    VStack(alignment: .leading) {
                        Text("Member ID: \(borrowing.memberID)")
                            .font(.headline)
                        Text("Book ID: \(borrowing.bookID)")
                        Text("Borrow Date: \(borrowing.borrowDate)")
                        Text("Return Date: \(borrowing.returnDate)")
                    }
                    .onTapGesture {
                        editingBorrowing = borrowing
                    }
                }
                .onDelete(perform: viewModel.deleteBorrowing)
            }
            .navigationTitle("Borrowings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddBorrowingView(viewModel: viewModel)
            }
            .sheet(item: $editingBorrowing) { borrowing in
                EditBorrowingView(borrowing: borrowing, viewModel: viewModel)
            }
            .onAppear {
                viewModel.fetchBorrowings()
            }
        }
    }
}
