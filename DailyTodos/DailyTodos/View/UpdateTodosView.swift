//
//  UpdateTodosView.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI
import SwiftData

struct UpdateTodosView: View {
    @Environment (\.dismiss) var dismiss
    @Bindable var item: TodoItemModel
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Pick date",
                       selection: $item.timestamp)
            Toggle("Important?", isOn: $item.isCritical)
            Button("Update") {
                dismiss()
            }
        }
        .navigationTitle("Update Todo")
    }
}

#Preview {
    UpdateTodosView(item: TodoItemModel())
}
