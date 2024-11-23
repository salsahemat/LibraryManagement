//
//  MultipleSelectionRow.swift
//  LibraryManagement
//
//  Created by Nuzulul Salsabila on 23/11/24.
//
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}
