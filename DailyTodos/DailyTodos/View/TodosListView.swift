//
//  TodosListView.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI
import SwiftData

enum TodoSortOption: String, CaseIterable {
    case title
    case date
    case category
}
extension TodoSortOption {
    var systemImage: String {
        switch self {
        case .title:
            return "textformat.size.larger"
        case .date:
            return "calendar"
        case .category:
            return "folder"
        }
    }
}

struct TodosListView: View {
    
    @Environment (\.modelContext) var context
    @State private var showCreateTodo = false
    @State private var showCreateCategory = false
    @State private var editTodo: TodoItemModel?
    @State private var searchText = ""
    @State private var selectedTodoSortOption = TodoSortOption.title
    
    @Query private var items: [TodoItemModel]
    var filteredData: [TodoItemModel] {
        if searchText.isEmpty {
            return items.sort(on: selectedTodoSortOption)
        }
        return items.filter({($0.title.lowercased().contains(searchText.lowercased())) || $0.category?.title.lowercased().contains(searchText.lowercased()) ?? false }).sort(on: selectedTodoSortOption)
    }
    
    var body: some View {
        
        NavigationStack {
            List {
                
                ForEach(filteredData) { item in
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
            .navigationTitle("Daily todos")
            .animation(.easeOut, value: filteredData)
            .searchable(text: $searchText, prompt: "Search todos/categories")
            .overlay {
                if filteredData.isEmpty {
                    ContentUnavailableView.search
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        showCreateCategory.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                
                ToolbarItemGroup(placement: .topBarTrailing){
                    Menu {
                        Picker("", selection: $selectedTodoSortOption) {
                            ForEach(TodoSortOption.allCases, id: \.rawValue) { option in
                                Label(option.rawValue.capitalized, image: option.systemImage)
                                    .tag(option)
                            }
                        }
                        .labelsHidden()
                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
                    }
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
                Label("Todos", systemImage: "plus")
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
private extension [TodoItemModel] {
    func sort(on option: TodoSortOption) -> Self {
        switch option {
        case .title:
            return self.sorted(by: { $0.title < $1.title})
        case .date:
            return self.sorted(by: { $0.timestamp < $1.timestamp})
        case .category:
            return self.sorted(by: {
                guard let titleFirst = $0.category?.title,
                      let titleSecond = $1.category?.title else { return false }
                return titleFirst < titleSecond
            })
        }
    }
}

#Preview {
    TodosListView()
}
