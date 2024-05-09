//
//  ProjectListView.swift
//  SaveApiImageInSwiftData
//
//  Created by Priyanka Mathur on 07/05/24.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    
    @Environment (\.modelContext) var context
    @Query private var listData: [Products]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.cyan.opacity(0.2),.indigo.opacity(0.1),.white], startPoint: .top, endPoint: .bottom)
                    //.blur(radius: 10)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    List(listData) { row in
                        Section {
                            ListSection(row: row)
                        }
                        .listRowBackground(Color.clear)
                        .clipShape(.rect(cornerRadius: 8))
                        .listSectionSeparator(.hidden)
                        .listRowSeparator(.visible)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(.clear)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .clipShape(.rect(cornerRadius: 8))
                    .navigationTitle("Product list")
                }
            }
        }
        .task {
            if listData.isEmpty {
                do {
                   try await fetchDataFromApi()
                } catch {
                    print(error)
                }
            }
        }
        
    }
}

private extension ProjectListView {
    func fetchDataFromApi() async throws {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            return
        }
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(ProductListModel.self, from: data)
        result.products.forEach {context.insert($0) }
        
    }
}

#Preview {
    ProjectListView()
        .modelContainer(for: [Products.self])
}

struct ListSection: View {
    
    var row: Products
    var body: some View {
        VStack {
            ListHeader(row: row)
            ListRow(row: row)
        }
        .background(.clear)
    }
}

struct ListHeader: View {
    var row: Products

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: row.thumbnail)) { image in
                image.image?
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(1.2, contentMode: .fit)
                    .frame(width: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }

            VStack {
                Spacer()
                Text(row.title)
                    .font(.headline)
                .fontWeight(.semibold)
                Spacer()
            }
            Spacer()
        }
        .padding([.top,.leading])
        .padding(.bottom, 5)
    }
}

struct ListRow: View {
    var row: Products

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(200))], spacing: 20, content: {
                ForEach(row.images, id: \.self) { item in
                    AsyncImage(url: URL(string: item)!) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipShape(.rect(cornerRadius: 12))
                            .padding(.top, 0)
                    } placeholder: {
                        VStack {
                            Spacer()
                            ProgressView()
                                .frame(width: 120)
                                .progressViewStyle(.circular).tint(.gray)
                            Spacer()
                        }
                    }
                    
                }
            })
            .padding([.leading, .trailing])
            .background(.clear)
            
        }
        .scrollIndicators(.hidden)
    }
    
    
}


