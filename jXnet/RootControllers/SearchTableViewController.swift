//
//  SearchTableViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 18.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    @IBOutlet weak var search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        self.hideKeyboardWhenTappedAround()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    

}
extension SearchTableViewController: UISearchBarDelegate{
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        searchKana = Kana.filter({($0.lowercased().contains(searchText.lowercased()))})
    //        filter = true
    //        tableView.reloadData()
    //        if searchText == "" {
    //            filter = false
    //            tableView.reloadData()
    //        }
    //    }dsadsadasdassasaas
//    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
//        filter = false
//        searchBar.text = ""
//        tableView.reloadData()
//    }

    
//    func confirm(_ completion: @escaping (Bool) -> ()) {
//        completion(true)
//    }
}
