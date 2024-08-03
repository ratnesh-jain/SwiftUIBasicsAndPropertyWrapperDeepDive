//
//  ContentView.swift
//  SwiftUIPropertyWrapperStudy
//
//  Created by Ratnesh Jain on 03/08/24.
//

import SwiftUI

struct ContentView: View {
    let store = PostViewModel()
    @Storage(key: "pageLimit") var pageLimit: Int = 10
    //@State private var offset: Int = 0
    
    var body: some View {
        List {
            ForEach(store.posts, id: \.title) { post in
                Text(post.title)
            }
        }
        .task {
            do {
                try await store.fetchPosts()
            } catch {
                print(error)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Text("PageLimit: \(pageLimit)")
            }
            ToolbarItem(placement: .topBarTrailing) {
                Stepper("PageLimit", value: $pageLimit)
            }
        })
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
