//
//  EditCategoryView.swift
//  LibraryManagement
//
//  Created by Nuzulul Salsabila on 23/11/24.
//
import SwiftUI

struct EditCategoryView: View {
    var category: Category
    @ObservedObject var categoryViewModel: CategoryViewModel
    @State private var categoryName: String

    init(category: Category, categoryViewModel: CategoryViewModel) {
        self.category = category
        self._categoryName = State(initialValue: category.name)
        self.categoryViewModel = categoryViewModel
    }

    var body: some View {
        VStack {
            TextField("Category Name", text: $categoryName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Save Changes") {
                categoryViewModel.updateCategory(categoryID: category.id, name: categoryName)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Edit Category")
    }
}

