//
//  PostViewModel.swift
//  SwiftUIPropertyWrapperStudy
//
//  Created by Ratnesh Jain on 03/08/24.
//

import Foundation

struct Post: Codable {
    var title: String
}

@Observable
class PostViewModel {
    var posts: [Post] = []
    
    @ObservationIgnored
    @Storage(key: "pageLimit") var pageLimit: Int = 10
    
    func fetchPosts() async throws {
        print(pageLimit)
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let (data, _) = try await URLSession.shared.data(from: url)
        self.posts = try JSONDecoder().decode([Post].self, from: data)
        //pageLimit += 1
        //print(pageLimit)
    }
}
