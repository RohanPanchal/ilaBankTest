//
//  ListViewModel.swift
//  ilaBankTest
//
//  Created by Rohan Panchal on 16/08/24.
//

import Foundation

class ListViewModel {
    static let shared = ListViewModel()
    static var listData = [ListModel]()

    //Parse JSON..
    func parseJson(completion: @escaping (Bool, String) -> Void) {
        guard let url = Bundle.main.url(forResource: "ListJSON", withExtension: "json") else {
            completion(false, "Local JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode([ListModel].self, from: data)
            ListViewModel.listData =  decodedData
            completion(true, "")
        } catch {
            completion(false, "Failed to load or decode JSON: \(error)")
        }
    }
}
