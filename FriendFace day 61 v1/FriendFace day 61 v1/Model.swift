//
//  Model.swift
//  FriendFace day 61 v1
//
//  Created by Marjo Salo on 28/04/2021.
//

import Foundation

struct User: Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var registrationDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY-MM-DD"
        formatter.dateStyle = .long
        return formatter.string(from: registered)
    }
}

struct Friend: Codable {
    let id: String
    let name: String
}
