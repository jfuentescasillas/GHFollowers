//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 09/07/21.
//

import Foundation


class NetworkManager {
	static let shared = NetworkManager()
	let baseURL: String = "https://api.github.com/users/"
	
	private init() {}
	
	
	func getFollowers(for username: String, page: Int, completionHandler: @escaping([Follower]?, ErrorMessage?) -> Void) {
		let endpoint: String = baseURL + "\(username)/followers?per_page=100&page=\(page)"
		
		guard let url = URL(string: endpoint) else {
			completionHandler(nil, .invalidUsername)
			
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error {
				completionHandler(nil, .unableToCompleteRequest)
				
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completionHandler(nil, .invalidResponse)
				
				return
			}
			
			guard let data = data else {
				completionHandler(nil, .invalidData)
				
				return
			}
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let followers = try decoder.decode([Follower].self, from: data)
				completionHandler(followers, nil)
			} catch {
				//completionHandler(nil, error.localizedDescription)  // Error message meant for developer
				completionHandler(nil, .invalidData)
			}
		}
		
		task.resume()
	}
}
