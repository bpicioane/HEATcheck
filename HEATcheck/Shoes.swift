//
//  Shoes.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/1/20.
//

import Foundation

class Shoes {
    
    var name = ""
    var shoeArray: [Shoe] = []
    
    private struct Returned: Codable {
        var results: [Shoe]
    }
    
    var urlString = "https://api.thesneakerdatabase.com/v1/sneakers?limit=10&sort=retailPrice:desc&name="
    
    func getData(completed: @escaping () -> ()) {
        guard let url = URL(string: "\(urlString)\(name.replacingOccurrences(of: " ", with: "%20"))") else {
            print("L. Something went wrong with the URL.")
            completed()
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("L. url session broke.")
            }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.shoeArray = returned.results
//                if returned.code == "OK" {
//                    print("this was returned: \(returned)")
//                    self.title = returned.items[0].title
//                } else {
//                    print("Barcode not in API.")
//                }
            } catch {
                print("L. JSON error.")
            }
            completed()
        }
        task.resume()
    }
    
    
}
