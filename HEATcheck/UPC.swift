//
//  UPC.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/1/20.
//

import Foundation

class UPC: Codable {
    
    private struct Returned: Codable {
        var code: String
        var items: [UPCItem]
    }
    
    var upc = ""
    var urlString = "https://api.upcitemdb.com/prod/trial/lookup?upc="
    var title = ""
    
    func getData(completed: @escaping () -> ()) {
        guard let url = URL(string: "\(urlString)\(upc)") else {
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
                if returned.code == "OK" {
                    print("this was returned: \(returned)")
                    self.title = returned.items[0].title
                } else {
                    print("Barcode not in API.")
                }
            } catch {
                print("L. JSON error.")
            }
            completed()
        }
        task.resume()
    }
    
}
