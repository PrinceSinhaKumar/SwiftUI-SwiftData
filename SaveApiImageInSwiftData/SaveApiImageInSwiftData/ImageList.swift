//
//  ImageList.swift
//  SaveApiImageInSwiftData
//
//  Created by Priyanka Mathur on 07/05/24.
//

import SwiftUI

struct ImageList: View {
    let outerListData = [
        OuterListItem(title: "List A", innerItems: ["Item 1", "Item 2", "Item 3"]),
        OuterListItem(title: "List B", innerItems: ["Item 4", "Item 5"]),
        OuterListItem(title: "List C", innerItems: ["Item 6"])
    ]
    
    var body: some View {
        OuterList(data: outerListData)
    }
}

#Preview {
    ImageList()
}

struct OuterList: View {
    let data: [OuterListItem]

    var body: some View {
        List(data) { item in
            OuterListItemView(item: item)
        }
    }
}


struct OuterListItem: Identifiable {
    let id: UUID = UUID()
    let title: String
    let innerItems: [String]
}

struct OuterListItemView: View {
    let item: OuterListItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.headline)
            HStack{
                InnerList(innerItems: item.innerItems)
            }
        }
        .padding()
    }
}
struct InnerList: View {
    let innerItems: [String]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [.init()], spacing: 5) {
                ForEach(innerItems, id: \.self) { _ in
                    Color.red.frame(width: 30)
                }
            }
        }
        
         // Optional: Apply a list style
    }
}
