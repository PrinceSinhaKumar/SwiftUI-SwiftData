//
//  TodosListView.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI
import SwiftData

struct TodosListView: View {
    
    @Environment (\.modelContext) var context
    @State private var showCreateTodo = false
    @State private var showCreateCategory = false
    @State private var editTodo: TodoItemModel?

    @Query private var items: [TodoItemModel]
    var body: some View {
        
        NavigationStack {
            List {
                if items.isEmpty {
                    ContentUnavailableView("No todos found", systemImage: "shippingbox", description: Text("Tap on New ToDo icon to generate todos"))
                } else {
                    ForEach(items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                
                                if item.isCritical {
                                    Image(systemName: "exclamationmark.3")
                                        .symbolVariant(.fill)
                                        .foregroundColor(.red)
                                        .font(.largeTitle)
                                        .bold()
                                }
                                
                                Text(item.title)
                                    .font(.largeTitle)
                                    .bold()
                                
                                Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                    .font(.callout)
                                
                                if let category = item.category {
                                    Text(category.title)
                                        .padding(8)
                                        .foregroundStyle(Color.blue)
                                        .bold()
                                        .background(Color.blue.opacity(0.1))
                                        .clipShape(.rect(cornerRadius: 8))
                                }
                            }
                            .onTapGesture(perform: {
                                withAnimation {
                                    editTodo = item
                                }
                            })
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    item.isCompleted.toggle()
                                }
                            } label: {
                                
                                Image(systemName: "checkmark")
                                    .symbolVariant(.circle.fill)
                                    .foregroundStyle(item.isCompleted ? .green : .gray)
                                    .font(.largeTitle)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        
                        
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    context.delete(item)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .symbolVariant(.fill)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Daily todos")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showCreateCategory.toggle()
                    }, label: {
                        Image(uiImage: .add)
                    })
                }
            }
            .sheet(isPresented: $showCreateCategory,
                   content: {
                NavigationStack {
                    GenerateCategoryView()
                }
            })
            .sheet(isPresented: $showCreateTodo,
                   content: {
                NavigationStack {
                    GenerateTodosView()
                }
                .presentationDetents([.medium])
            })
            .sheet(item: $editTodo) {
                editTodo = nil
            } content: { item in
                NavigationStack {
                    UpdateTodosView(item: item)
                }
                .presentationDetents([.medium])

            }
        }
        .safeAreaInset(edge: .bottom,
                       alignment: .leading) {
            Button(action: {
                showCreateTodo.toggle()
            }, label: {
                Label("New ToDo", systemImage: "plus")
                    .bold()
                    .font(.title2)
                    .padding(8)
                    .background(.gray.opacity(0.1),
                                in: Capsule())
                    .padding(.leading)
                    .symbolVariant(.circle.fill)
                
            })
        }
    }
}

#Preview {
    TodosListView()
}
