//
//  GenerateCategoryView.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 06/05/24.
//

import SwiftUI
import SwiftData

struct GenerateCategoryView: View {
    @Environment (\.modelContext) var context
    @Environment (\.dismiss) var dismiss
    @State private var title: String  = ""
    @Query private var categories: [CategoryItemModel]
    var body: some View {
        NavigationStack {
            List {
                Section("Category title") {
                    TextField("Enter title",text: $title)
                    Button("Add category") {
                        let category = CategoryItemModel(title: title)
                        context.insert(category)
                        title = ""
                    }
                }
                Section("Categories") {
                    
                    if categories.isEmpty {
                        ContentUnavailableView("No Categories", systemImage: "archivebox")
                    } else {
                        ForEach(categories) { category in
                            Text(category.title)
                                .swipeActions() {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            context.delete(category)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                            .symbolVariant(.fill)
                                    }
                                }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Dismiss")
                    })
                }
            }
            .navigationTitle("Generate category")
        }
    }
}

//#Preview {
//    GenerateCategoryView()
//}
