//
//  PostView.swift
//  SparHub
//
//  Created by Dmitry Zasenko on 01.04.26.
//

import SwiftUI

struct PostView: View {
    
    @ObservedObject var postsVM: PostsVM
    @Binding var post: Post
    @Binding var tabBarHeight: CGFloat
    
    @State private var titleHeight: CGFloat = .zero
    @State private var scrollOffset: CGPoint = .zero
    @State private var showTitle = false
    
    let showUserPostsBtn: Bool
    
    var body: some View {
        OffsetObservingScrollView(offset: $scrollOffset) {
            Text(post.title)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                titleHeight = proxy.size.height
                            }
                    }
                }
            if let url = post.imgUrl {
                AsyncImage(url: URL(string: url)) { img in
                    img
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
                .padding(.bottom)
            }
            
            Text(post.text)
                .font(.callout)
                .foregroundColor(.primary)
                .padding()
            
            Text(post.date.formatted(date: .abbreviated, time: .shortened))
                .padding()
            Button {
                withAnimation {
                    post.isLiked.toggle()
                }
                postsVM.likePost(id: post.id)
            } label: {
                AppImages.iconHeart
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(post.isLiked ? .red : .secondary)
                    .frame(height: 40)
            }
            .padding()
            if (showUserPostsBtn) {
                NavigationLink {
                    Color.gray
                } label: {
                    HStack {
                        AppImages.iconUser
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(post.user.name)
                    }
                    .bold()
                    .foregroundStyle(.black)
                    .padding()
                    .padding(.horizontal)
                    .background(.green)
                    .clipShape(Capsule())
                    .padding()
                }
            }
            Spacer(minLength: tabBarHeight + 20)
        }
        .onChange(of: scrollOffset, initial: false) { oldValue, newValue in
            if (oldValue.y != 0 ) {
                showTitle = newValue.y > titleHeight + 20
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(post.title)
                    .opacity(showTitle ? 1 : 0)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        post.isMarked.toggle()
                    }
                    postsVM.markPost(id: post.id)
                } label: {
                    AppImages.iconBookmark
                        .foregroundStyle(post.isMarked ? .yellow : .secondary)
                }
            }
        }
        .navigationTitle(post.title)
        .navigationBarTitleDisplayMode(.inline)
        .animation(.default, value: showTitle)
    }
}

#Preview {
    NavigationStack {
        PostView(postsVM: PostsVM(), post: .constant(postsDTO[4]), tabBarHeight: .constant(50), showUserPostsBtn: true)
    }
}



struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content
    
    @State private var localPosition: CGPoint = .zero // локальная переменная для отслеживания изменений
    
    var body: some View {
        content()
            .background(GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        localPosition = geometry.frame(in: coordinateSpace).origin
                    }
                    .onChange(of: geometry.frame(in: coordinateSpace).origin) { _, newValue in
                        localPosition = newValue
                    }
            })
            .onChange(of: localPosition) { _, newValue in
                // Обновляем binding только если позиция реально изменилась
                if newValue != position {
                    position = newValue
                }
            }
    }
}

private extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }
        
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}

struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}
