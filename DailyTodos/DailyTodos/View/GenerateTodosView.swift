//
//  ContentView.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI
import SwiftData

struct GenerateTodosView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var item = TodoItemModel()
    @State private var selectedCategory: CategoryItemModel?
    @Query private var categories: [CategoryItemModel]
    
    var body: some View {
        List {
            Section("General information") {
                TextField("Name", text: $item.title)
                DatePicker("Pick date",
                           selection: $item.timestamp)
                Toggle("Important?", isOn: $item.isCritical)
            }
            Section("Categories") {
                Picker("", selection: $selectedCategory) {
                    ForEach(categories) { category in
                        Text(category.title)
                            .tag(category as CategoryItemModel?)
                    }
                    Text("None")
                        .tag(nil as CategoryItemModel?)
                }
                .labelsHidden()
                .pickerStyle(.inline)
            }
            Section {
                Button("Generate") {
                    withAnimation {
                        save()
                    }
                    dismiss()
                }
            }
            
        }
        .navigationTitle("Generate Todo")
    }
}

private extension GenerateTodosView {
    func save() {
        context.insert(item)
        item.category = selectedCategory
        selectedCategory?.todos?.append(item)
    }
}

#Preview {
    GenerateTodosView()
        .modelContainer(for: TodoItemModel.self)
}
