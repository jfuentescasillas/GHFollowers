//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 07/07/21.
//

import UIKit


class FollowersListVC: UIViewController {
	// MARK: - Properties
	var username: String!
	var collectionView: UICollectionView!
	

	// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureViewController()
		configureCollectionView()
		getFollowers()
    }
	
	
	// MARK: - viewWillAppear
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		 
		// Moving this line of code to viewWill Appear deals with a bug in which the NavigationBar was involved (it showed when it was not supposed to appear)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	
	// MARK: - configure Methods
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	
	func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
		view.addSubview(collectionView)
		
		collectionView.backgroundColor = .systemPink
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	
	
	// MARK: - Get Followers
	private func getFollowers() {
		NetworkManager.shared.getFollowers(for: username, page: 1) { result in
			switch result {
			case .success(let followers):
				print("Followers.count = \(followers.count)")
				print("Followers = \(followers)")
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
			}
		}
	}
	
	
	// MARK: - CreateFollowLayout Method
	func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minimumItemSpacing: CGFloat = 10
		let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)  // We do minimum spacing * 2 because in a 3 column layout, there are 2 spaces between the 3 items. The space between the left item and the middle item. And the space between the middle item and the right item.
		let itemWidth = availableWidth / 3
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
		
		return flowLayout
	}
}
