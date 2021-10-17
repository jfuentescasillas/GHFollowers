//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 09/07/21.
//

import UIKit


class NetworkManager {
	static let shared 			= NetworkManager()
	private let baseURL: String = "https://api.github.com/users/"
	let cache 					= NSCache<NSString, UIImage>()
	let decoder 				= JSONDecoder()
	
	private init() {
		decoder.keyDecodingStrategy  = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
	}
	

	// Old code 1
	/*func getFollowers(for username: String, page: Int, completionHandler: @escaping(Result<[Follower], GFError>) -> Void) {
		let endpoint: String = baseURL + "\(username)/followers?per_page=100&page=\(page)"
		
		guard let url = URL(string: endpoint) else {
			completionHandler(.failure(.invalidUsername))
			
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error {
				completionHandler(.failure(.unableToCompleteRequest))
				
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completionHandler(.failure(.invalidResponse))
				
				return
			}
			
			guard let data = data else {
				completionHandler(.failure(.invalidData))
				
				return
			}
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let followers = try decoder.decode([Follower].self, from: data)
				completionHandler(.success(followers))
			} catch {
				//completionHandler(nil, error.localizedDescription)  // Error message meant for developer
				completionHandler(.failure(.invalidData))
			}
		}
		
		task.resume()
	}*/
	
	
	// iOS 15 Update
	func getFollowers(for username: String, page: Int) async throws -> [Follower] {
		let endpoint: String = baseURL + "\(username)/followers?per_page=100&page=\(page)"
		
		guard let url = URL(string: endpoint) else {
			throw GFError.invalidUsername
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw GFError.invalidResponse
		}
		
		do {
			return try decoder.decode([Follower].self, from: data)
		} catch {
			throw GFError.invalidData
		}
	}
	
	
	// Old code 2
	/*func getUserInfo(for username: String, completionHandler: @escaping(Result<User, GFError>) -> Void) {
		let endpoint: String = baseURL + "\(username)"
		
		guard let url = URL(string: endpoint) else {
			completionHandler(.failure(.invalidUsername))
			
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error {
				completionHandler(.failure(.unableToCompleteRequest))
				
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completionHandler(.failure(.invalidResponse))
				
				return
			}
			
			guard let data = data else {
				completionHandler(.failure(.invalidData))
				
				return
			}
			
			do {
				let decoder 					= JSONDecoder()
				decoder.keyDecodingStrategy 	= .convertFromSnakeCase
				
				let user = try decoder.decode(User.self, from: data)
				completionHandler(.success(user))
			} catch {
				//completionHandler(nil, error.localizedDescription)  // Error message meant for developer
				completionHandler(.failure(.invalidData))
			}
		}
		
		task.resume()
	}  */
	
		
	func getUserInfo(for username: String) async throws -> User {
		let endpoint: String = baseURL + "\(username)"
		
		guard let url = URL(string: endpoint) else {
			throw GFError.invalidUsername
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw GFError.invalidResponse
		}
		
		do {
			// Return user
			return try decoder.decode(User.self, from: data)
		} catch {
			throw GFError.invalidData
		}
	}
	
	
	// iOS 15 Update
	// In this method we don't use throws because we don't care about the error
	func downloadImage(from urlString: String) async -> UIImage? {
		let cacheKey = NSString(string: urlString)
		
		// Store downloaded image in cache
		if let image = cache.object(forKey: cacheKey) {
			return image
		}
		
		guard let url = URL(string: urlString) else { return nil }
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			
			guard let image = UIImage(data: data) else { return nil }
			
			cache.setObject(image, forKey: cacheKey)
			
			return image
		} catch {
			return nil
		}
	}
	
	// Old Code
	/*func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
		let cacheKey = NSString(string: urlString)
		
		// Store downloaded image in cache
		if let image = cache.object(forKey: cacheKey) {
			completed(image)
			
			return  // We return so that we don't run the following code
		}
		
		guard let url = URL(string: urlString) else {
			completed(nil)
			
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			
			guard let self = self, error == nil,
				  let response = response as? HTTPURLResponse, response.statusCode == 200,
				  let data = data,
				  let image = UIImage(data: data) else {
				completed(nil)
				
				return
			}
			
			self.cache.setObject(image, forKey: cacheKey)
			
			completed(image)
		}
		
		task.resume()
	} */
}
