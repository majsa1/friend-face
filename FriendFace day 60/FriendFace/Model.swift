//
//  Model.swift
//  FriendFace
//
//  Created by Marjo Salo on 20/04/2021.
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
        formatter.dateStyle = .long
        return formatter.string(from: registered)
    }
}

struct Friend: Codable {
    let id: String
    let name: String
}
