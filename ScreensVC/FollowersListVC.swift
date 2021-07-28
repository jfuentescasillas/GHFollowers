//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 07/07/21.
//

import UIKit


class FollowersListVC: GFDataLoadingVC {
	enum Section { case main } // Our "main section" (aka our collectionView)
	
	// MARK: - Properties
	var username: String!
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	
	var followers 				= [Follower]()
	var filteredFollowers 		= [Follower]()
	var page: Int 				= 1
	
	var hasMoreFollowers: Bool 	= true
	var isSearching: Bool 		= false
	var isLoadingMoreFollowers: Bool = false
	
	
	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		
		self.username 	= username
		title 			= username
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureViewController()
		configureSearchController()
		configureCollectionView()
		getFollowers(username: username, page: page)
		configureDataSource()
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
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
		navigationItem.rightBarButtonItem = addButton
	}
	
	
	func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
		view.addSubview(collectionView)
		
		collectionView.delegate = self
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	
	
	func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater   = self
		searchController.searchBar.placeholder 	= "Search for a username"
		searchController.obscuresBackgroundDuringPresentation = false  // Background won't get obscured when searching in the searchbar
		
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}
	
	
	// MARK: - Get Followers
	private func getFollowers(username: String, page: Int) {
		showLoadingView()
		isLoadingMoreFollowers = true
		
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			guard let self = self else { return }
			
			self.dismissLoadingView()
			
			switch result {
			case .success(let followers):
				self.updateUI(with: followers)
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
			}
			
			self.isLoadingMoreFollowers = false
		}
	}
	
	
	private func updateUI(with followers: [Follower]) {
		if followers.count < 100 { self.hasMoreFollowers = false }
		
		self.followers.append(contentsOf: followers)
		
		if self.followers.isEmpty {
			let message: String = "This user does not have any followers 🥺 Go follow them 🤓"
			
			DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
			
			return
		}
		
		self.updateData(on: self.followers)
	}
	
	
	// MARK: - Configure DataSource
	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			
			return cell
		})
	}
	
	
	func updateData(on followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		//dataSource.apply(snapshot, animatingDifferences: true)  // Funcionó bien. OK.
		DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }  // Intentar después con esta línea. Comentar arriba. También funcionó. OK.
	}
	
	
	// MARK: - AddButtonTapped used in configureViewController()
	@objc private func addButtonTapped() {
		showLoadingView()
		
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			
			self.dismissLoadingView()
			
			switch result {
			case .success(let user):
				self.addUserToFavorites(user: user)
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something Went Wrong",
												message: error.rawValue,
												buttonTitle: "OK")
			}
		}
	}
	
	
	private func addUserToFavorites(user: User) {
		let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
		
		PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
			guard let self = self else { return }
			
			guard let error = error else {
				self.presentGFAlertOnMainThread(title: "Success!",
												message: "This user is now in your favorites list!",
												buttonTitle: "Excellent")
				
				return
			}
			
			self.presentGFAlertOnMainThread(title: "Something Went Wrong",
											message: error.rawValue,
											buttonTitle: "OK")
		}
	}
}


// MARK: - Extension: UICollectionViewDelegate
extension FollowersListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY 		= scrollView.contentOffset.y  // y coordinate (up and down)
		let contentHeight 	= scrollView.contentSize.height  // The entire scrollview, if there are 5,000 followers, it will be very tall
		let height 			= scrollView.frame.size.height  // Screen's height
		
		if offsetY > contentHeight - height {
			guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
			
			page += 1
			
			getFollowers(username: username, page: page)
		}
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let activeArray 	= isSearching ? filteredFollowers : followers
		let follower		= activeArray[indexPath.item]
		let destVC 			= UserInfoVC()
		destVC.username		= follower.login
		destVC.delegate 	= self
		
		let navController 	= UINavigationController(rootViewController: destVC)		
		present(navController, animated: true)
	}
}


// MARK: - Extension: UISearchResultsUpdating
extension FollowersListVC: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else {
			filteredFollowers.removeAll()
			updateData(on: followers)
			isSearching = false
			
			return
		}
		
		isSearching			= true
		filteredFollowers 	= followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
		
		updateData(on: filteredFollowers)
	}
}


// MARK: - Extension: UserInfoVCDelegate (before named FollowersListVCDelegate)
extension FollowersListVC: UserInfoVCDelegate {
	// Get Followers for that user
	func didRequestFollowers(for username: String) {
		self.username 	= username
		title			= username
		page 			= 1
		
		followers.removeAll()
		filteredFollowers.removeAll()
		
		if isSearching {
			navigationItem.searchController?.searchBar.text = ""
			navigationItem.searchController?.isActive 		= false
			navigationItem.searchController?.dismiss(animated: false)
			
			isSearching = false
		}
		
		collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
		//updateData(on: followers)
		
		getFollowers(username: username, page: page)
	}
}
