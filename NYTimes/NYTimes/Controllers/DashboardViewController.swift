//
//  DashboardViewController.swift
//  NYTimes
//
//  Created by Hafiz Abdul kareem on 07/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import UIKit
import Foundation

class DashboardViewController: UITableViewController {
    private var dashboardModel: DashboardSectionModel?
    private var filterResultArray: [Result]?
    private var resultSearchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = NetworkClient(endpoint: Endpoints.getDashboardItems)
        let dashboardAdapter = DashboardNetworkAdapter(networkClient: client)
        dashboardAdapter.getDashboardItems() { sections, error in
            if let error = error {
                // Show error alert
                return
            }
            self.dashboardModel = sections
            self.filterResultArray = self.dashboardModel?.results
            
            DispatchQueue.main.async {
                self.addSearchController()
                self.tableView.reloadData()
            }
        }
    }
    
    private func addSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.showsSearchResultsController = true
            controller.searchResultsUpdater = self
            controller.delegate = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.default
            controller.searchBar.barTintColor = .white
            controller.searchBar.backgroundColor = .clear
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
}

//#MARK: TableView dataSource
extension DashboardViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = dashboardModel else {
            return 0
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let resultArray = filterResultArray else {
            return 0
        }
        return resultArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.identifier, for: indexPath) as? SectionTableViewCell else {
            return UITableViewCell()
        }
            
        if let result = filterResultArray?[indexPath.row] {
            cell.titleLabel.text = result.title
            cell.bylineLabel.text = result.byline
            cell.publishedDateLabel.text = result.publishedDate
        }
        
        return cell
    }
}

//#MARK: NavigationBar button Actions
extension DashboardViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text
        if query?.isEmpty ?? true {
            filterResultArray = dashboardModel!.results
            tableView.reloadData()
        }else {
            if query!.count >= 3 {
                filterResultArray?.removeAll()
                filterResultArray = dashboardModel!.results?.filter{ $0.title.contains(query!) }
                tableView.reloadData()
            }else {
                filterResultArray = dashboardModel!.results
                tableView.reloadData()
            }
        }
    }
}
