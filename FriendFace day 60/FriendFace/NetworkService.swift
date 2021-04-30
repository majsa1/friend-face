//
//  NetworkService.swift
//  FriendFace
//
//  Created by Marjo Salo on 20/04/2021.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()

    func getUsers(onSuccess: @escaping ([User]) -> ()) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedUsers = try? decoder.decode([User].self, from: data) {
                DispatchQueue.main.async {
                    onSuccess(decodedUsers)
                }
            } else {
                print("Failed to decode: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        .resume()
    }

}
