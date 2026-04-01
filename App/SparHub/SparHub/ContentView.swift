//
//  ContentView.swift
//  SparHub
//
//  Created by Dmitry Zasenko on 01.04.26.
//

import SwiftUI

enum Router {
    case home
    case user
    case search
    case add
}

struct ContentView: View {

    @State private var router: Router = .home
        
    var body: some View {
        ZStack {
            switch router {
            case .home:
                Color.blue
            case .search:
                Color.yellow
            case .user:
                Color.green
            case .add:
                Color.orange
            }
            HStack(spacing: 40) {
                TabButton(router: $router, route: .home, img: AppImages.iconHome)
                TabButton(router: $router, route: .search, img: AppImages.iconSearch)
                TabButton(router: $router, route: .add, img: AppImages.iconPlus)
                TabButton(router: $router, route: .user, img: AppImages.iconUser)
            }
            .padding()
            .padding(.horizontal)
            .background(.red)
            .clipShape(Capsule())
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .animation(.smooth, value: router)
    }
}

struct TabButton: View {
    
    @Binding var router: Router

    let route: Router
    let img: Image
    
    var body: some View {
        Button {
            router = route
        } label: {
            img
                .bold()
                .foregroundStyle(router == route ? .black : .secondary)
        }
    }
}

#Preview {
    ContentView()
}
