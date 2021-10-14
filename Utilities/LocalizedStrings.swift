//
//  LocalizedStrings.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 29/07/21.
//

import Foundation


struct LocalizedKeys {
	// MARK: - Alert Controller
	struct alertControllerDefaultTitles {
		static let somethingWentWrongDefault 	= "somethingWentWrongDefault".localized
		static let unableToRequestDefault 	 	= "unableToRequestDefault".localized
		static let badStuffHappenedTitle 	 	= "badStuffHappenedTitle".localized
		static let successTitle 		 	 	= "successTitle".localized
		static let emptyUsernameTitle 		 	= "emptyUsernameTitle".localized
		static let unableToRemoveTitle			= "unableToRemoveTitle".localized
		static let invalidURLTitle			= "invalidURLTitle".localized
		static let noFollowersTitle			= "noFollowersTitle".localized
	}
	
	
	struct alertControllerMessages {
		static let successMsg 					= "successMsg".localized
		static let emptyUsernameMsg				= "emptyUsernameMsg".localized
		static let invalidURLMsg				= "invalidURLMsg".localized
		static let noFollowersMsg				= "noFollowersMsg".localized
	}
	
	
	struct alertControllerErrorMessages {
		static let invalidUsername 				= "invalidUsername".localized
		static let unableToCompleteRequest 		= "unableToCompleteRequest".localized
		static let unableToCompleteTask			= "unableToCompleteTask".localized
		static let invalidData 					= "invalidData".localized
		static let unableToFavorite 			= "unableToFavorite".localized
		static let alreadyInFavorites 			= "alreadyInFavorites".localized
	}
	
	
	struct alertControllerButtonTitle {
		static let successButtonTitle 			= "successBtn".localized
		static let okButtonTitle 				= "okBtn".localized
		static let sadButtonTitle 				= "sadBtn".localized
	}
	
	
	// MARK: - Search ViewController UI
	struct searchBarPlaceholder {
		static let searchVCTextFieldPlaceholder	= "searchVCTextFieldPlaceholder".localized
		static let resultsTextFieldPlaceholder  = "resultsTextFieldPlaceholder".localized
	}
	
	
	// ViewControllers Titles
	struct vcTitles {
		static let favoritesVC 	 				= "favoritesVC".localized
	}
	
	
	// VC buttons
	struct buttonsTitles {
		static let githubProfile 				= "gitHubProfile".localized
		static let getFollowers  				= "getFollowers".localized
	}
	
	
	// VC Labels
	struct labelsContent {
		static let noFollowers 	 	 			= "noFollowers".localized
		static let emptyState 	 	 			= "emptyState".localized
		static let publicRepos					= "publicRepos".localized
		static let publicGists					= "publicGists".localized
		static let followersLbl	 	 			= "followersLbl".localized
		static let followingLbl	 	 			= "followingLbl".localized
		static let inGithubSinceLbl				= "inGithubSinceLbl".localized
	}
	
	
	// User Information Elements
	struct userInformationElements {
		static let noLocationDefault 			= "noLocationDefault".localized
		static let noBioDefault 	 			= "noBioDefault".localized
	}
}
