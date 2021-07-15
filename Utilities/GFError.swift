//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 09/07/21.
//

import Foundation


enum GFError: String, Error {
	case invalidUsername = "This username created an invalid request. Please try again"
	case unableToCompleteRequest = "Unable to complete your request. Please check your internet connection"
	case invalidResponse = "Invalid response from the server. Please try again"
	case invalidData = "Invalid data received from the server. Please try again"
}
