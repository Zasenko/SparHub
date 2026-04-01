//
//  PostsVM.swift
//  SparHub
//
//  Created by Dmitry Zasenko on 01.04.26.
//

import SwiftUI
import Combine

final class PostsVM: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var posts: [Post] = []
    @Published var categories: [PostCategory] = [.all]
    @Published var selectedCetegory: PostCategory = .all
    @Published var showAddPost = false
    
    private var fetchedUsers: [Int] = []
    private var allPosts: [Post] = []

    init() {
        debugPrint("[PostsVM] init")
        fetchPosts()
    }
    
    private func fetchPosts() {
        debugPrint("[PostsVM] fetchPosts")
        Task {
            sleep(2)
            var newCategories: [PostCategory] = [.all]
            let formatter = ISO8601DateFormatter()
            var new = postsDTO.map { post in
                var newPost = Post(id: post.id, title: post.title, text: post.text, imgUrl: post.imgUrl, category: post.category, dateString: post.dateString, user: post.user)
                newPost.date = formatter.date(from: post.dateString) ?? Date()
                if !newCategories.contains(where: { $0 == post.category }) {
                    newCategories.append(post.category)
                }
                return newPost
            }
            new.sort(by: { $0.date > $1.date})
            await MainActor.run { [weak self] in
                self?.allPosts = new
                self?.posts = new
                self?.isLoading.toggle()
                self?.categories = newCategories
            }
        }
        
    }
    
    func sort(category: PostCategory) {
        Task {
            let new = allPosts.filter({ post in
                category == .all || category == post.category
            })
            await MainActor.run { [weak self] in
                guard let self else { return }
                withAnimation {
                    self.posts = new
                    self.selectedCetegory = category
                }
            }
        }
    }
}
