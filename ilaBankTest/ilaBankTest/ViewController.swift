//
//  ViewController.swift
//  ilaBankTest
//
//  Created by Rohan Panchal on 16/08/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    
    var currentListItems = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        self.setupTableView()

        self.getListData()
    }
}

// MARK: - Get Data
extension ViewController {
    func getListData() {
        ListViewModel.shared.parseJson(completion: { success, error in
            if success {
                if let firstListItems = ListViewModel.listData.first?.items {
                    self.currentListItems = firstListItems
                                        
                    self.listTableView.reloadData()
                }
            }
        })
    }
}

// MARK: - Setup UI
extension ViewController {
   // Setup list items tableview
    func setupTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "SearchbarView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchbarView")
        listTableView.register(UINib.init(nibName: "CarouselViewCell", bundle: nil), forCellReuseIdentifier: "carouselViewCell")
        listTableView.register(UINib.init(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "listCell")
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return currentListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselViewCell", for: indexPath)  as! CarouselViewCell
            cell.listData = ListViewModel.listData
            cell.carouselViewCellDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)  as! ListCell
            let item = currentListItems[indexPath.row]
            cell.listItemName?.text = item.itemName
            cell.listItemImage.image = UIImage(named: item.itmeImage ?? "")

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchbarView") as! SearchbarView
            headerView.selectedListItems = currentListItems
            headerView.searchbarViewDelegate = self
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 70)
            
            headerView.searchBarView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0).isActive = true
            headerView.searchBarView.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
            headerView.searchBarView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0).isActive = true
            headerView.searchBarView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
            
            headerView.layoutIfNeeded()
            
            return headerView
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1 : 70
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 280 : 60
    }
}

// MARK: - CarouselViewCellDelegate
extension ViewController: CarouselViewCellDelegate {
    func carouselImageScrolled(atIndex: Int) {
        currentListItems = ListViewModel.listData[atIndex].items ?? [Item]()
        listTableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    func carouselPageIndicatorChanged(atIndex: Int) {
        currentListItems = ListViewModel.listData[atIndex].items ?? [Item]()
        listTableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
}

// MARK: - SearchbarViewDelegate
extension ViewController: SearchbarViewDelegate {
    func searchFieldTextDidChange(searchedList: [Item]) {
        self.currentListItems = searchedList
        self.listTableView.reloadData()
    }
}
