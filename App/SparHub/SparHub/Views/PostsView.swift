//
//  PostsView.swift
//  SparHub
//
//  Created by Dmitry Zasenko on 01.04.26.
//

import SwiftUI

struct PostsView: View {
    
    @ObservedObject var postsVM: PostsVM
    
    var body: some View {
        NavigationStack {
            if (postsVM.isLoading) {
                ProgressView()
            } else {
                List {
                    ForEach($postsVM.posts) { post in
                        NavigationLink {
                            Color.yellow
                        } label: {
                            PostCell(post: post.wrappedValue)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
                    .listRowSeparator(.hidden)
                }
                .listSectionSeparator(.hidden)
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle("Posts")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            ForEach(postsVM.categories, id: \.self) { category in
                                Button {
                                    postsVM.sort(category: category)
                                } label: {
                                    Text(category.rawValue)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(postsVM.selectedCetegory == category ? .red : .clear)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                        } label: {
                            AppImages.iconSort
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    PostsView(postsVM: PostsVM())
}
