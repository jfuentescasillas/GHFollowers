//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 06/07/21.
//

import UIKit


class FavoriteListVC: GFDataLoadingVC {
	// MARK: - Properties
	let tableView = UITableView()
	var favorites = [Follower]()
	

	// MARK: - ViewDidLoad and ViewWillAppear
    override func viewDidLoad() {
        super.viewDidLoad()

		configureViewController()
		configureTableView()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		getFavorites()
	}
	
	
	// MARK: - Configuration Methods
	func configureViewController() {
		title 					= LocalizedKeys.vcTitles.favoritesVC
		view.backgroundColor 	= .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	
	func configureTableView() {
		view.addSubview(tableView)
		
		tableView.frame 		= view.bounds
		tableView.rowHeight		= 80
		tableView.delegate 		= self
		tableView.dataSource 	= self
		tableView.removeExcessCells()
		
		tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
	}
	
	
	// MARK: - Get Favorites Method
	func getFavorites() {
		PersistanceManager.retrieveFavorites { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let favorites):
				self.updateUI(with: favorites)
				
			case .failure(let error):
				DispatchQueue.main.async {
					self.presentGFAlert(
						title: LocalizedKeys.alertControllerDefaultTitles.somethingWentWrongDefault,
						message: error.rawValue,
						buttonTitle: LocalizedKeys.alertControllerButtonTitle.okButtonTitle)
				}
			}
		}
	}
	
	
	private func updateUI(with favorites: [Follower]) {
		if favorites.isEmpty {
			self.showEmptyStateView(with: LocalizedKeys.labelsContent.emptyState, in: self.view)
		} else {
			self.favorites = favorites
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.view.bringSubviewToFront(self.tableView)
			}
		}
	}
}


// MARK: - Extensions: TableView Delegates and DataSource
extension FavoriteListVC: UITableViewDelegate, UITableViewDataSource {
	// MARK: - TableView DataSource Methods
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favorites.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
		let favorite = favorites[indexPath.row]
		cell.set(favorite: favorite)
		
		return cell
	}
	
	
	// MARK: - TableView Delegate Methods
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favorite 	= favorites[indexPath.row]
		let destVC		= FollowersListVC(username: favorite.login)
		
		navigationController?.pushViewController(destVC, animated: true)
	}
	
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		
		PersistanceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
			guard let self = self else { return }
			
			guard let error = error else {
				self.favorites.remove(at: indexPath.row)
				self.tableView.deleteRows(at: [indexPath], with: .left)
				
				return
			}
			
			DispatchQueue.main.async {
				self.presentGFAlert(title: LocalizedKeys.alertControllerDefaultTitles.unableToRemoveTitle,
									message: error.rawValue,
									buttonTitle: LocalizedKeys.alertControllerButtonTitle.okButtonTitle)
			}
		}
	}
}
