//
//  ShoeData.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/1/20.
//

import Foundation

struct Shoe: Codable {
    
    var brand: String
    var retailPrice: Int
    var title: String
    var media: [String: String]

}