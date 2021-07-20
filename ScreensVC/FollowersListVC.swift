//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 07/07/21.
//

import UIKit


class FollowersListVC: UIViewController {
	enum Section { case main } // Our "main section" (aka our collectionView)
	
	// MARK: - Properties
	var username: String!
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	var followers = [Follower]()
	var page: Int = 1
	var hasMoreFollowers: Bool = true
	

	// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureViewController()
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
	}
	
	
	func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
		view.addSubview(collectionView)
		
		collectionView.delegate = self
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	
	
	// MARK: - Get Followers
	private func getFollowers(username: String, page: Int) {
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let followers):
				/*print("Followers.count = \(followers.count)")
				print("Followers = \(followers)")*/
				
				if followers.count < 100 { self.hasMoreFollowers = false }
				
				self.followers.append(contentsOf: followers)
				self.updateData()
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
			}
		}
	}
	
	
	// MARK: - Configure DataSource
	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			
			return cell
		})
	}
	
	
	func updateData() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		dataSource.apply(snapshot, animatingDifferences: true)  // Funcionó bien. OK.
		//DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }  // Intentar después con esta línea. Comentar arriba. También funciona
	}
}


extension FollowersListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y  // y coordinate (up and down)
		let contentHeight = scrollView.contentSize.height  // The entire scrollview, if there are 5,000 followers, it will be very tall
		let height = scrollView.frame.size.height  // Screen's height
		
		/*print("OffsetY: \(offsetY)")
		print("ContentHeight: \(contentHeight)")
		print("height: \(height)")
		print("------------")*/
		
		if offsetY > contentHeight - height {
			guard hasMoreFollowers else { return }
			
			page += 1
			
			getFollowers(username: username, page: page)
		}
	}
}
