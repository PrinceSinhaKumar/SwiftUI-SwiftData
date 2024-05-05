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
    
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Pick date",
                       selection: $item.timestamp)
            Toggle("Important?", isOn: $item.isCritical)
            Button("Generate") {
                withAnimation {
                    context.insert(item)
                }
                dismiss()
            }
        }
        .navigationTitle("Generate Todo")
    }
}
#Preview {
    GenerateTodosView()
        .modelContainer(for: TodoItemModel.self)
}
