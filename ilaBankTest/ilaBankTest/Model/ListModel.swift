//
//  ListModel.swift
//  ilaBankTest
//
//  Created by Rohan Panchal on 16/08/24.
//

import UIKit

struct ListModel: Decodable {
    let carouselImage: String?
    let items: [Item]?
}

struct Item: Decodable {
    let itmeImage: String?
    let itemName: String?
}
