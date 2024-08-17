//
//  SearchbarView.swift
//  ilaBankTest
//
//  Created by Rohan Panchal on 17/08/24.
//

import UIKit

// MARK: - SearchbarViewDelegate
protocol SearchbarViewDelegate: AnyObject {
    func searchFieldTextDidChange(searchedList: [Item])
}

class SearchbarView: UITableViewHeaderFooterView {
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchbarViewDelegate: SearchbarViewDelegate?
    var selectedListItems = [Item]()
    
    override func awakeFromNib() {
        self.setupSearchBar()
    }
    
    // Setup searchbar
    func setupSearchBar() {
        searchBar.delegate = self
        
        // Style the search bar
        let searchTextField = searchBar.searchTextField
        searchTextField.backgroundColor = UIColor.white // Change to light background
        searchTextField.layer.cornerRadius = 10 // Rounded corners
        searchTextField.clipsToBounds = true
        searchTextField.borderStyle = .none
        
        // Change text color and font
        searchTextField.textColor = UIColor.gray
        searchTextField.font = UIFont.systemFont(ofSize: 16)
    }
}

// MARK: - UISearchBarDelegate
extension SearchbarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let listItems = searchText.isEmpty ? selectedListItems : selectedListItems.filter { $0.itemName?.lowercased().contains(searchText.lowercased()) ?? false }
        
        searchbarViewDelegate?.searchFieldTextDidChange(searchedList: listItems)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
