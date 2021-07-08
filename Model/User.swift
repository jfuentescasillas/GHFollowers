//
//  User.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 08/07/21.
//

import Foundation


struct User: Codable {
	var login: String
	var avatarUrl: String
	var name: String?
	var location: String?
	var bio: String?
	var publicRepos: Int
	var publicGists: Int
	var htmlUrl: String
	var following: Int
	var followers: Int
	var createdAt: String
}
