//
//  User.swift
//  SparHub
//
//  Created by Dmitry Zasenko on 01.04.26.
//

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let imgUrl: String?
}

let usersDTO: [User] = [
    User(id: 1, name: "Dima", imgUrl: nil),
    User(id: 2, name: "Olga", imgUrl: nil),
    User(id: 3, name: "Alex Johnson", imgUrl: nil),
    User(id: 4, name: "Maria Schmidt", imgUrl: nil),
    User(id: 5, name: "George Stone", imgUrl: nil)
]
