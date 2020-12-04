//
//  ShoeData.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/1/20.
//

import Foundation

struct Shoe: Codable, Equatable {
    
    var brand: String
    var retailPrice: Int
    var title: String
    var year: Int
    var media: [String: String]

}
