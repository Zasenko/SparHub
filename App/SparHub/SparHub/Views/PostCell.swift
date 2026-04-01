//
//  PostCell.swift
//  SparHub
//
//  Created by Dmitry Zasenko on 01.04.26.
//

import SwiftUI

struct PostCell: View {
    
    let post: Post
    
    var body: some View {
        VStack(spacing: 10){
            Text(post.title)
                .font(.title2).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 20) {
                if let url = post.imgUrl {
                    AsyncImage(url: URL(string: url)) { img in
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                }
                Text(post.text)
                    .font(.callout)
                    .foregroundColor(.primary)
                    .lineLimit(5)
            }
            .padding(.vertical)
            HStack(spacing: 20) {
                HStack{
                    AppImages.iconUser
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(post.isLiked ? .red : .secondary)
                    Text(post.user.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                AppImages.iconBookmark
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(post.isLiked ? .red : .secondary)
                AppImages.iconHeart
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(post.isLiked ? .red : .secondary)
            }
            .padding(.bottom)
            Divider()
        }
    }
}

#Preview {
    PostCell(post: postsDTO[0])
}
