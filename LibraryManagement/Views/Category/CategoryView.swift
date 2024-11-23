//
//  CategoryView.swift
//  LibraryManagement
//
//  Created by Nuzulul Salsabila on 23/11/24.
//
import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryViewModel = CategoryViewModel()
    @State private var newCategoryName: String = ""
    @State private var isAddingCategory: Bool = false
    @State private var selectedCategory: Category? = nil
    @State private var isEditingCategory: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                // Add Category Section
                if isAddingCategory {
                    TextField("Enter category name", text: $newCategoryName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add Category") {
                        if !newCategoryName.isEmpty {
                            categoryViewModel.addCategory(name: newCategoryName)
                            newCategoryName = ""
                            isAddingCategory.toggle()
                        }
                    }
                    .padding()
                } else {
                    Button("Add Category") {
                        isAddingCategory.toggle()
                    }
                    .padding()
                }

                // List Categories
                List {
                    ForEach(categoryViewModel.categories) { category in
                        HStack {
                            Text(category.name)
                            Spacer()

                            // Edit Button
                            Button(action: {
                                selectedCategory = category
                                isEditingCategory.toggle()
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }

                            // Delete Button
                            Button(action: {
                                categoryViewModel.deleteCategory(categoryID: category.id)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }

                // Edit Category Sheet
                .sheet(isPresented: $isEditingCategory) {
                    if let category = selectedCategory {
                        EditCategoryView(category: category, categoryViewModel: categoryViewModel)
                    }
                }
            }
            .onAppear {
                categoryViewModel.fetchCategories()
            }
        }
    }
}
