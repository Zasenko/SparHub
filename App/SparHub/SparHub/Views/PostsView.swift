//
//  PostsView.swift
//  SparHub
//
//  Created by Dmitry Zasenko on 01.04.26.
//

import SwiftUI

struct PostsView: View {
    
    @ObservedObject var postsVM: PostsVM
    @Binding var tabBarHeight: CGFloat
    @State private var sortBarHeight: CGFloat = .zero
    
    var body: some View {
        NavigationStack {
            if (postsVM.isLoading) {
                ProgressView()
            } else {
                ZStack(alignment: .top) {
                    List {
                        Spacer(minLength: sortBarHeight)
                        ForEach($postsVM.posts) { post in
                            NavigationLink {
                                PostView(postsVM: postsVM, post: post, tabBarHeight: $tabBarHeight, showUserPostsBtn: true)
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
                    sortingView
                }
                .navigationTitle("Posts")
                .toolbarVisibility(.hidden, for: .automatic)
            }
        }
    }
    
    private var sortingView: some View {
        HStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(postsVM.categories, id: \.self) { category in
                        Button {
                            postsVM.sort(category: category)
                        } label: {
                            Text(category.rawValue)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(postsVM.selectedCetegory == category ? .red : Color(uiColor: .systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .bold()
                        }
                    }
                }
                .padding(.horizontal)
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                sortBarHeight = proxy.size.height
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
            if postsVM.hasMarkedPosts {
                Button {
                    postsVM.showMarkedPosts()
                } label: {
                    AppImages.iconBookmark
                        .padding()
                        .bold()
                        .background(postsVM.markedSelected ? .red : Color(uiColor: .systemBackground))
                        .foregroundStyle(.yellow)
                        .clipShape(.circle)
                }
                .padding(.trailing)
            }
        }
        .padding(.bottom)
        .background {
            GeometryReader { proxy in
                LinearGradient(colors: [Color(uiColor: .systemBackground), Color.clear], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.container, edges: .top)
                    .onAppear {
                        sortBarHeight = proxy.size.height
                    }
            }
        }
    }
}

#Preview {
    PostsView(postsVM: PostsVM(), tabBarHeight: .constant(50.0))
}
